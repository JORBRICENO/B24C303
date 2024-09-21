using {LogaliGroup as service} from '../service';

annotate service.VH_DepartmentSet with {
    @title : 'Departments'
    ID @Common:{
        Text : deparment,
        TextArrangement : #TextOnly
    }
};
