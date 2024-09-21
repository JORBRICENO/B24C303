using {LogaliGroup as service} from '../service';

using from './annotations-contacts';

annotate service.SupplierSet with {
    @title : 'Suppliers'
    ID @Common : { 
        Text : supplierName,
        TextArrangement : #TextOnly,
    };
    supplier     @title: 'Supplier';
    supplierName @title: 'Supplier Name';
    webAddress   @title: 'Web Address';
};

annotate service.SupplierSet with @(

    UI.FieldGroup #SupplierInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : supplier,
            },
            {
                $Type : 'UI.DataField',
                Value : supplierName,
            },
            {
                $Type : 'UI.DataField',
                Value : webAddress,
            },
        ],
    }
);
