using {LogaliGroup as services} from '../service';


annotate services.VH_SubCategorySet with {
    ID @title : 'Sub-Categories';
};

annotate services.VH_SubCategorySet with {
    ID @Common: {
        Text : subCategory,
        TextArrangement : #TextOnly
    }
};
