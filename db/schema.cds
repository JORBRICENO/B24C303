namespace com.logaligroup;

using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

type decimal : Decimal(6, 2);

//Agregar nuevo campo para tener visibilidad del campo tanto en la tabla como en el ObjectPage (Title)
entity Products : cuid, managed {
    product      : String(8);
    productName  : String(40);
    productUrl   : String               @UI.IsImageURL;
    content      : LargeBinary          @UI.IsImage @Core.MediaType      : mediaType  @Core.ContentDisposition.Filename: fileName;
    mediaType    : String               @Core.IsMediaType;
    fileName     : String;
    description  : LargeString;
    availability : Association to VH_Status;
    rating       : Decimal(3, 2);
    price        : decimal              @Measures.ISOCurrency: currency;
    category     : Association to VH_Categories; //category_ID
    subcategory  : Association to VH_SubCategories; //subcategory_ID
    currency     : String default 'USD' @Common.IsCurrency;
    criticality  : Int16;
    detail       : Composition of Details; // detail_ID
    supplier     : Association to Suppliers;
    toReviews    : Composition of many  Reviews
                       on toReviews.product = $self;
    toInventory  : Composition of many Inventory
                       on toInventory.product = $self;
};

entity Details : cuid {
    baseUnit   : String(2);
    heigth     : decimal   @Measures.Unit: unitVolume;
    width      : decimal   @Measures.Unit: unitVolume;
    depth      : decimal   @Measures.Unit: unitVolume;
    weight     : decimal   @Measures     : {Unit: unitWeight};
    unitVolume : String(2) @Common.IsUnit;
    unitWeight : String(2) @Common.IsUnit;
};

entity Suppliers : cuid {
    supplier     : String(9);
    supplierName : String(40);
    webAddress   : String;
    contact      : Association to Contacts; // contact_ID
};

entity Contacts : cuid {
    fullName    : String(80);
    email       : String(120);
    phoneNumber : String(12);
};

entity Reviews : cuid {
    rating       : Decimal(3, 2);
    creationDate : Date;
    user         : String(40);
    review       : LargeString;
    product      : Association to Products; //Almacena el ID del Producto en el campo product_ID
};

entity Inventory : cuid {
    deparment   : Association to VH_Departments;
    stockNumber : Int16;
    min         : Int16;
    max         : Int16;
    value       : Int32;
    lotSize     : decimal @Measures.Unit: unit;
    quantity    : decimal @Measures.Unit: unit;
    unit        : String  @Common.IsUnit default 'EA';
    product     : Association to Products; //Almacena el ID del Producto en el campo product
};


//VH = Value Help
entity VH_Categories : cuid {
    category        : String;
    toSubCategories : Association to many VH_SubCategories
                          on toSubCategories.category = $self;
};

entity VH_SubCategories : cuid {
    subCategory : String;
    category    : Association to VH_Categories;
};

entity VH_Departments : cuid {
    deparment : String;
};

entity VH_Status : CodeList {
    key code : String enum {
            InStock        = 'In Stock';
            LowAvalibility = 'Low Avalibility';
            NotInStock     = 'Not In Stock';
        };
};

/** Entidades de ejemplo para poner en practica los filtros dependientes con el ValueList In and Out */

entity Test : cuid {
    department : Association to Departments;
    children   : Association to Employees;
};

entity Departments : cuid {
    department  : String;
    toEmployees : Composition of many Employees
                      on toEmployees.parent = $self;
};

entity Employees : cuid {
    firstName : String;
    lastName  : String;
    parent    : Association to Departments;
};
