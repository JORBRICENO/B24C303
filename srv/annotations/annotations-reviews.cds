using {LogaliGroup as service} from '../service';

annotate service.ReviewSet with {
    product      @title: 'Product';
    review       @title: 'Review Text';
    user         @title: 'Reviewed' @Common: {
        Text : creationDate,
        TextArrangement : #TextLast,
    };
    rating       @title: 'Rating';
    creationDate @title: 'Reviewed';
};


annotate service.ReviewSet with @(
    Common.SemanticKey  : [
        user
    ],
    UI.HeaderInfo  : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Review',
        TypeNamePlural : 'Reviews',
        Title : {
            $Type : 'UI.DataField',
            Value : user,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : creationDate,
        },
    },
    UI.LineItem  : [
        // {
        //     $Type : 'UI.DataField',
        //     Value : rating,
        // },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint',
            ![@HTML5.CssDefaults] : {
                $Type : 'HTML5.CssDefaultsType',
                width : '8rem',
            },
            Label : 'Rating',
        },
        // {
        //     $Type : 'UI.DataField',
        //     Value : creationDate,
        // },
        {
            $Type : 'UI.DataField',
            Value : user,
        },
        {
            $Type : 'UI.DataField',
            Value : review,
        },
    ],
    UI.DataPoint  : {
        $Type : 'UI.DataPointType',
        Value : rating,
        Visualization: #Rating
    },
    UI.FieldGroup  : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : rating,
            },
            {
                $Type : 'UI.DataField',
                Value : user,
            },
            {
                $Type : 'UI.DataField',
                Value : creationDate,
            },
            {
                $Type : 'UI.DataField',
                Value : review,
            },
        ],
    },
    UI.Facets:[
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup',
            ID : 'Review',
        },
    ]
);
