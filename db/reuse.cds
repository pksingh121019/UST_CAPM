namespace ust.reuse;

//reuse type of single field
type Guid : String(32);

//group of fields

aspect addesss{
    houseNo : Integer;
    street : String(32);
    sector : String(44);
    landmark: String(80);
    city : String(55);
    country: String(4);
}


