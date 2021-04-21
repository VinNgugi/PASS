page 51513838 "Incubates Shortlisting"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Incubation;
    SourceTableView = where (Status = filter (Released));
    Caption = 'Incubates Shortlisting';
    Editable = false;
    // CardPageId = "Incubates Shortlisting Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }

                field("Document Date"; "Document Date")
                {

                }
                field(Name; Name)
                {

                }

                field("Global Dimension 4 Code"; "Global Dimension 4 Code")
                {

                }

                field("Requested By"; "Requested By")
                {

                }
                field(Status; Status)
                {

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Applicants List")
            {
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Applicants in Residential";
                RunPageLink = "Incubation Code" = field ("No."), Submitted = const (true), "Resident Selection" = const (true), Admitted = const (false);
            }
        }
    }

}