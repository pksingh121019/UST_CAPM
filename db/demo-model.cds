using { ust.reuse as reuse  } from './reuse';
using { cuid, managed, temporal } from '@sap/cds/common';


namespace ust.demo;

context master{
    entity student : reuse.addesss {
        key id: reuse.Guid;
        nameFirst: String(80);
        nameLast: String(80);
        age: Integer ;
        //foreign key
        class : Association to semester;
    }

    entity semester {
        key id: reuse.Guid;
        name: String(30);
        specialization: String(80);
        hod: String(44);
    }
    entity books {
        key code : String(32);
        name: localized String(80);
        author: String(44);
        
    }
}

context transaction {
    entity subs : cuid , managed, temporal {
        student : Association to  one master.student;
        books : Association to one master.books;
    }
}