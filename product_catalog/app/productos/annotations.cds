using MyFirstService as service from '../../srv/service';

annotate service.productos with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Name',
                Value: Name
            },
            {
                $Type: 'UI.DataField',
                Label: 'Descripcion',
                Value: Descripcion
            },
            {
                $Type: 'UI.DataField',
                Label: 'ImageUrl',
                Value: ImageUrl
            },
            {
                $Type: 'UI.DataField',
                Label: 'ReleaseDate',
                Value: ReleaseDate
            },
            {
                $Type: 'UI.DataField',
                Label: 'DiscontinuedDate',
                Value: DiscontinuedDate
            },
            {
                $Type: 'UI.DataField',
                Label: 'Price',
                Value: Price
            },
            {
                $Type: 'UI.DataField',
                Label: 'Height',
                Value: Height
            },
            {
                $Type: 'UI.DataField',
                Label: 'Width',
                Value: Width
            },
            {
                $Type: 'UI.DataField',
                Label: 'Depth',
                Value: Depth
            },
            {
                $Type: 'UI.DataField',
                Label: 'Quantity',
                Value: Quantity
            },
             {
                $Type: 'UI.DataField',
                Label: 'PriceCondition',
                Value: PriceCondition
            },
             {
                $Type: 'UI.DataField',
                Label: 'PriceDetermination',
                Value: PriceDetermination
            }
        ],
    },
    UI.Facets                    : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneratedGroup',
    }, ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: 'Name',
            Value: Name,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Description',
            Value: Descripcion,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Depth',
            Value: Depth,
        }
    ],
);
