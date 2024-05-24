const cds = require("@sap/cds");

module.exports = async (srv) => {
  const { Risks, BusinessPartners } = srv.entities;

  srv.after("READ", Risks, (data) => {
    const risks = Array.isArray(data) ? data : [data];
    risks.forEach((risk) => {
      if (risk.impact >= 100000) {
        risk.criticality = 1;
      } else {
        risk.criticality = 2;
      }

      switch (risk.prio_code) {
        case "H":
          risk.PrioCriticality = 1;
          break;
        case "M":
          risk.PrioCriticality = 2;
          break;
        case "L":
          risk.PrioCriticality = 3;
          break;
        default:
          break;
      }
    });
  });

  const BPsrv = await cds.connect.to("API_BUSINESS_PARTNER");

  srv.on("READ", BusinessPartners, async (req) => {
    req.query.where("LastName <> '' and FirstName <> '' ");

    return await BPsrv.transaction(req).send({
      query: req.query,
      headers: {
        apikey: process.env.apikey,
      },
    });
  });

  srv.on("READ", Risks, async (req, next) => {
    if (!req.query.SELECT.columns) return next();

    const expandIndex = req.query.SELECT.columns.findIndex(
      ({ expand, ref }) => expand && ref[0] === "bp"
    );

    if (expandIndex < 0) return next();

    req.query.SELECT.columns.splice(expandIndex, 1);

    if (
      !req.query.SELECT.columns.find((column) =>
        column.ref.find((ref) => ref == "bp_BusinessPartner")
      )
    ) {
      req.query.SELECT.columns.push({ ref: ["bp_BusinessPartner"] });
    }

    const risks = await next();
    const risksArray = Array.isArray(risks) ? risks : [risks];

    const bpIDs = risksArray.map((risk) => risk.bp_BusinessPartner);

    const busienssPartners = await BPsrv.transaction(req).send({
      query: SELECT.from(srv.entities.BusinessPartners).where({
        BusinessPartner: bpIDs,
      }),
      headers: {
        apikey: process.env.apikey,
      },
    });

    const bpMap = {};
    for (const businessPartner of busienssPartners)
      bpMap[businessPartner.BusinessPartner] = businessPartner;

    for (const note of risksArray) {
      note.bp = bpMap[note.bp_BusinessPartner];
    }
    return risks;
  });
};
