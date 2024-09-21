using {LogaliGroup as services} from '../service';

using from './annotations-suppliers';
using from './annotations-details';
using from './annotations-reviews';
using from './annotations-stock';

annotate services.ProductSet with @odata.draft.enabled;


annotate services.ProductSet with {
    productName @title : 'Product Name';
    product      @title: 'Product'  @Common: {
        Text           : productName,
        TextArrangement: #TextFirst,
    };
    productUrl   @title: 'Image';
    description  @title: 'Description';
    availability @title: 'Availability';
    rating       @title: 'Average Rating';
    price        @title: 'Price';
    currency     @title: 'Currency';
    category     @title: 'Category';
    subcategory  @title: 'Sub-Category';
    supplier     @title: 'Supplier';
};

annotate services.ProductSet with {
    category    @Common: {
        Text           : category.category,
        TextArrangement: #TextOnly,
        ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_CategorySet',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: category_ID, // Local --> Representa los datos de la entidad ProductSet
                ValueListProperty: 'ID', // VL --> Representa los datos de la entidad auxilar: VH_Category
            }],
        },
    };
    subcategory @Common: {
        Text           : subcategory.subCategory,
        TextArrangement: #TextOnly,
        ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_SubCategorySet',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterIn',
                    LocalDataProperty: category_ID, // En este campo que se llama category_ID Categories vas a buscar el ID que esta almacenado
                    ValueListProperty: 'category_ID', // y debe ser igual al campo category_ID que tengo en mi entidad Subcategories
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: subcategory_ID, // En este campo que se llama subcategory_ID vas almacenar
                    ValueListProperty: 'ID', // Este ID que seleccione el usuario.
                },
            ]
        }
    };
    supplier @Common : { 
        Text : supplier.supplierName,
        TextArrangement : #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'SupplierSet',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : supplier_ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
     }
};

annotate services.ProductSet with @(
    Common.SideEffects  : {
        $Type : 'Common.SideEffectsType',
        SourceProperties : [
            supplier_ID
        ],
        TargetEntities : [
            supplier
        ],
    },
    UI.SelectionFields   : [
        product,
        productName,
        category_ID,
        subcategory_ID
    ],
    UI.HeaderInfo        : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Product',
        TypeNamePlural: 'Products',
        Title         : {
            $Type: 'UI.DataField',
            Value: productName,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: product,
        },
    },
    UI.HeaderFacets      : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#GroupA'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#GroupB'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#GroupC',
            Label : 'Product Description',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#GroupD',
            Label : 'Availability',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#GroupE',
            Label : 'Price',
        },
    ],
    UI.FieldGroup #GroupA: {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type: 'UI.DataField',
            Value: content,
            Label: '',
        }]
    },
    UI.FieldGroup #GroupB: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: category_ID,
            },
            {
                $Type: 'UI.DataField',
                Value: subcategory_ID,
            },
            {
                $Type: 'UI.DataField',
                Value: supplier_ID
            },
        ],
    },
    UI.FieldGroup #GroupC: {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : description,
                Label : '',
            },
        ],
    },
    UI.FieldGroup #GroupD : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : availability_code,
                Criticality : criticality,
                Label : '',
            },
        ],
    },
    UI.FieldGroup #GroupE : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : price,
                Label : '',
            },
        ],
    },
    UI.Facets  : [
        {
            $Type : 'UI.CollectionFacet',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Target : 'supplier/@UI.FieldGroup#SupplierInformation',
                    Label : 'Information',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Target : 'supplier/contact/@UI.FieldGroup#SupplierContact',
                    Label : 'Contact Person',
                },  
            ],
            Label : 'Supplier Information',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'detail/@UI.FieldGroup#ProductInformation',
            Label : 'Product Information',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'toReviews/@UI.LineItem',
            Label : 'Reviews',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'toInventory/@UI.LineItem',
            Label : 'Inventory Information',
        },
    ],
    UI.LineItem          : [
        {
            $Type: 'UI.DataField',
            Value: content,
        },
        {
            $Type: 'UI.DataField',
            Value: product,
        },
        // {
        //     $Type : 'UI.DataField',
        //     Value : productName,
        // },
        {
            $Type                : 'UI.DataField',
            Value                : category_ID,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '8rem',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : subcategory_ID,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '8rem',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : availability_code,
            Criticality          : criticality,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '6rem',
            },
        },
        // {
        //     $Type : 'UI.DataField',
        //     Value : rating,
        // },
        {
            $Type                : 'UI.DataFieldForAnnotation',
            Target               : '@UI.DataPoint',
            Label                : 'Average Rating',
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '8rem',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : price,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '8rem',
            },
        },
    ],
    UI.DataPoint         : {
        $Type        : 'UI.DataPointType',
        Value        : rating,
        Visualization: #Rating,
        Title        : 'Rating',
    }
);
