tableextension 51513264 "Qualification Ext" extends Qualification
{
    fields
    {
        // Add changes to table fields here

        field(50000; "Professional Body"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Professional Body";
        }
        field(50001; "Qualification Type"; Option)
        {
            OptionMembers = " ",Academic,Professional,Technical,Experience,"Personal Attributes";
        }
    }

}