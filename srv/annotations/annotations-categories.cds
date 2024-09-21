using {LogaliGroup as services} from '../service';

annotate services.VH_CategorySet with {
    ID       @title: 'Categories';
    category @title: 'Category';
};


annotate services.VH_CategorySet with {
    ID @Common: {
        Text           : category,
        TextArrangement: #TextOnly,
    }
};
