page 51513640 "Repeating Clients"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;


    layout
    {

        area(Content)
        {
            repeater("Clients List")
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                }
                field("Name 2"; "Name 2")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {

        }

    }


    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //******************** fILTER TO GET ONLY REPEATING CLIENTS*****************//
        FilterGroup(10);
        SetRange("Customer Posting Group", 'CLIENTS');
        FilterGroup(0);

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

    end;
}
