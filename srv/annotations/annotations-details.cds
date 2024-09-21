using {LogaliGroup as service} from '../service';

annotate service.DetailSet with {
    baseUnit   @title              : 'Base Unit';
    width      @title              : 'Product Width';
    heigth     @title              : 'Product Height';
    depth      @title              : 'Product Depth';
    weight     @title              : 'Weight';
    unitVolume @Common.FieldControl: #ReadOnly;
    unitWeight @Common.FieldControl: #ReadOnly;
};

annotate service.DetailSet with @(UI.FieldGroup #ProductInformation: {
    $Type: 'UI.FieldGroupType',
    Data : [
        {
            $Type                  : 'UI.DataField',
            Value                  : baseUnit,
            ![@Common.FieldControl]: #ReadOnly,
        },
        {
            $Type: 'UI.DataField',
            Value: width,
        },
        {
            $Type: 'UI.DataField',
            Value: heigth,
        },
        {
            $Type: 'UI.DataField',
            Value: depth,
        },
        {
            $Type: 'UI.DataField',
            Value: weight,
        },
    ],
    Label: 'Technical Data',
}, );
