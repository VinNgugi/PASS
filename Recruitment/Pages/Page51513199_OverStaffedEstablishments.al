page 51513199 "Over Staffed Establishments"
{
    PageType = List;
    Caption = 'Over Staffed Establishments';
    UsageCategory = Lists;
    SourceTable = "Company Jobs";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Job ID"; "Job ID")
                {

                }
                field("Job Description"; "Job Description")
                {

                }
                field("No. of Posts"; "No. of Posts")
                {

                }
                field("Occupied Establishments"; "Occupied Establishments")
                {

                }
                field(Variance; Variance)
                {

                }
            }
        }

    }
    trigger OnOpenPage()

    begin
        RESET;
        IF FIND('-') THEN BEGIN
            REPEAT
                CALCFIELDS("Occupied Establishments");
                // MESSAGE('%1',"Occupied Position");
                "Vacant Establishments" := "No. of Posts" - "Occupied Establishments";
                Variance := "No. of Posts" - "Occupied Establishments";
                MODIFY;
            UNTIL NEXT = 0;
        END;
        RESET;
        SETCURRENTKEY("Vacant Establishments");
        SETFILTER("Vacant Establishments", '<%1', 0);
    end;
}
