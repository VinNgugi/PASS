tableextension 51513254 "Company Information Ext" extends "Company Information"
{
    fields
    {
        field(50025; "Administrator Email"; Text[50])
        {
            DataClassification = CustomerContent;
            caption = 'Administrator Email';
            ExtendedDatatype = EMail;
        }
        field(50027; "NSSF Employer No"; Code[20])
        {

        }
        field(50028; "Region Code"; Code[20])
        {

        }
        field(50029; "Company TIN No"; Code[20])
        {

        }
    }

    var
        myInt: Integer;
}