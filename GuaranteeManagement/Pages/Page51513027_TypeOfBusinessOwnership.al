page 51513027 "Type of Business Ownership"
{
    PageType = Card;

    SourceTable = "Type of Business Owership";
    Caption = 'Type of Business Ownership';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Code)
                {


                }
                field(Description; Description)
                {

                }
                field("Ownership Type"; "Ownership Type")
                {

                }
            }
            part(RequiredDocuments; "Ownership Requirements")
            {
                Caption = 'Required Document';
                SubPageLink = Code = field (Code);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}