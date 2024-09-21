using {LogaliGroup as service} from '../service';


annotate service.InventorySet with {
    stockNumber @title: 'Stock Bin Number' @Common.FieldControl : #ReadOnly;
    deparment   @title: 'Department';
    lotSize     @title: 'Lot Size';
    quantity    @title: 'Ordered Quantity';
    min @title : 'Min';
    max @title : 'Max';
    value @title : 'Value';
    unit @Common.FieldControl : #ReadOnly
};

annotate service.InventorySet with {
    deparment @Common : { 
        Text : deparment.deparment,
        TextArrangement : #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'VH_DepartmentSet',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : deparment_ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
     }
};



annotate service.InventorySet with @(
    UI.HeaderInfo  : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Stock',
        TypeNamePlural : 'Stocks',
        Title : {
            $Type : 'UI.DataField',
            Value : stockNumber,
        },
    },
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : stockNumber,
        },
        {
            $Type : 'UI.DataField',
            Value : deparment_ID,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.Chart',
            Label : '',
        },
        // {
        //     $Type : 'UI.DataField',
        //     Value : value,
        // },
        {
            $Type : 'UI.DataField',
            Value : lotSize,
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
        },
    ],
    Common.SemanticKey  : [
        stockNumber
    ],
    UI.DataPoint  : {
        $Type : 'UI.DataPointType',
        MinimumValue : min,
        MaximumValue : max,
        Value : value,
        CriticalityCalculation : {
            $Type : 'UI.CriticalityCalculationType',
            ImprovementDirection : #Maximize,
            ToleranceRangeLowValue : 50,
            DeviationRangeLowValue : 10,
        },
        ![@Common.Label] : '',
    },
    UI.Chart  : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Bullet,
        Title : '',
        Measures : [
            value
        ],
        MeasureAttributes : [
            {
                $Type : 'UI.ChartMeasureAttributeType',
                DataPoint : '@UI.DataPoint',
                Measure : value,
            },
        ],
    },
    UI.FieldGroup  : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : stockNumber,
            },
            {
                $Type : 'UI.DataField',
                Value : deparment_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : min,
            },
            {
                $Type : 'UI.DataField',
                Value : max,
            },
            {
                $Type : 'UI.DataField',
                Value : value,
            },
            {
                $Type : 'UI.DataField',
                Value : lotSize,
            },
            {
                $Type : 'UI.DataField',
                Value : quantity,
            },
        ],
    },
    UI.Facets  : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup',
        },
    ],
);
