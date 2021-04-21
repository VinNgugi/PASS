page 51514011 "Bank Recovery Lines"
{

    PageType = ListPart;
    SourceTable = "Bank Recovery Lines";
    Caption = 'Bank Recovery Lines';
    UsageCategory = None;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Required"; "Document Required")
                {
                    ApplicationArea = All;
                }
                field("Document Provided"; "Document Provided")
                {
                    ApplicationArea = All;
                }
                field("Brief Explanation"; "Brief Explanation")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
