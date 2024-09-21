using {LogaliGroup as service} from '../service';

annotate service.ConctacSet with {
    fullName    @title: 'Full Name';
    email       @title: 'Email';
    phoneNumber @title: 'Phone Number'
};


annotate service.ConctacSet with @(
    UI.FieldGroup #SupplierContact : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : fullName,
                ![@Common.FieldControl] : #ReadOnly,
            },
            {
                $Type : 'UI.DataField',
                Value : email,
                ![@Common.FieldControl] : #ReadOnly,
            },
            {
                $Type : 'UI.DataField',
                Value : phoneNumber,
                ![@Common.FieldControl] : #ReadOnly,
            },
        ],
    },
);
