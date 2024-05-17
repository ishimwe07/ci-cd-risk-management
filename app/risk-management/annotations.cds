using RiskService as service from '../../srv/risk-service';
using from '../../db/schema';
annotate service.Risks with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'title',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : 'owner',
                Value : owner,
            },
            {
                $Type : 'UI.DataField',
                Label : 'prio_code',
                Value : prio_code,
            },
            {
                $Type : 'UI.DataField',
                Label : 'descr',
                Value : descr,
            },
            {
                $Type : 'UI.DataField',
                Label : 'impact',
                Value : impact,
            },
            {
                $Type : 'UI.DataField',
                Label : 'criticality',
                Value : criticality,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PrioCriticality',
                Value : PrioCriticality,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Risk Overview',
            ID : 'RiskOverview',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Risk Details',
                    ID : 'RiskDetails',
                    Target : '@UI.FieldGroup#RiskDetails',
                },],
        },
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Mitigation Overview',
            ID : 'MitigationOverview',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Mitigation Details',
                    ID : 'MitigationDetails',
                    Target : '@UI.FieldGroup#MitigationDetails',
                },],
        },],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Title}',
            Value : title,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Owner}',
            Value : owner,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Priority}',
            Value : prio_code,
            Criticality : PrioCriticality,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Impact}',
            Value : impact,
            Criticality : criticality,
        },
        {
            $Type : 'UI.DataField',
            Value : miti.descr,
            Label : '{i18n>Mitigation}',
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : 'bp/@Communication.Contact#contact',
            Label : '{i18n>BusinessPartner}',
        },
    ],
);

annotate service.Risks with {
    miti @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Mitigations',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : miti_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'descr',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'owner',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'timeline',
            },
        ],
        Label : 'Mitigation',
    }
};

annotate service.Risks with @(
    UI.SelectionFields : [
        prio_code,
    ]
);
annotate service.Risks with {
    prio @Common.Label : '{i18n>Priority}'
};

annotate service.Risks with @(
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : descr,
        },
        TypeImageUrl : 'data:image/jpeg;base64,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',
    }
);
annotate service.Risks with @(
    UI.FieldGroup #RiskDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
                Label : '{i18n>Title}',
            },{
                $Type : 'UI.DataField',
                Value : owner,
                Label : '{i18n>Owner}',
            },{
                $Type : 'UI.DataField',
                Value : descr,
                Label : '{i18n>Description}',
            },{
                $Type : 'UI.DataField',
                Value : prio_code,
                Criticality : PrioCriticality,
            },{
                $Type : 'UI.DataField',
                Value : impact,
                Label : '{i18n>Impact}',
                Criticality : criticality,
            },
            {
                $Type : 'UI.DataFieldForAnnotation',
                Target : 'bp/@Communication.Contact#contact1',
                Label : '{i18n>BusinessPartner}',
            },],
    }
);
annotate service.Risks with @(
    UI.FieldGroup #MitigationDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : miti_ID,
                Label : '{i18n>Mitigation}',
            },{
                $Type : 'UI.DataField',
                Value : miti.owner,
                Label : '{i18n>Owner}',
            },{
                $Type : 'UI.DataField',
                Value : miti.timeline,
                Label : '{i18n>Timeline}',
            },],
    }
);
annotate service.Risks with {
    miti @Common.Text : {
            $value : miti.descr,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.Risks with {
    miti @Common.ValueListWithFixedValues : true
};
annotate service.Mitigations with {
    ID @Common.Text : descr
};
annotate service.Risks with {
    prio @Common.Text : {
            $value : prio.descr,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.BusinessPartners with @(
    Communication.Contact #contact : {
        $Type : 'Communication.ContactType',
        fn : FullName,
    }
);
annotate service.BusinessPartners with @(
    Communication.Contact #contact1 : {
        $Type : 'Communication.ContactType',
        fn : FullName,
    }
);
