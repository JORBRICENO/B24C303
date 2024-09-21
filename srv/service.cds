using {com.logaligroup as entities} from '../db/schema';

service LogaliGroup {
    entity ProductSet        as projection on entities.Products;
    entity DetailSet         as projection on entities.Details;
    entity SupplierSet       as projection on entities.Suppliers;
    entity ConctacSet        as projection on entities.Contacts;
    entity ReviewSet         as projection on entities.Reviews;
    entity InventorySet      as projection on entities.Inventory;
    entity VH_CategorySet    as projection on entities.VH_Categories;
    entity VH_SubCategorySet as projection on entities.VH_SubCategories;
    entity VH_DepartmentSet  as projection on entities.VH_Departments;
    entity VH_StatusSet      as projection on entities.VH_Status;
}