page 51513837 "Incubates Exit Card"
{
    PageType = Card;

    SourceTable = "Incubates Register";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                }
                field("Middle Name"; "Middle Name")
                {
                    Editable = false;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                }
                field("Job ID"; "Job ID")
                {
                    Editable = false;
                }
                field("Job Description"; "Job Description")
                {
                    Editable = false;
                }
                field("Date of Exit"; "Date of Exit")
                {

                }
                field("Incubate Type"; "Incubate Type")
                {
                    Editable = false;
                }
                field("Incubation Start Date"; "Incubation Start Date")
                {

                }
                field("Incubation Period"; "Incubation Period")
                {

                }
                field("Incubation End Date"; "Incubation End Date")
                {

                }
                field("Reason for Exit"; "Reason for Exit")
                {

                }
                field(Details; Details)
                {
                    MultiLine = true;
                }

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