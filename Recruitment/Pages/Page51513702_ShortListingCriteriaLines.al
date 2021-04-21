page 51513702 "ShortListing Criteria Lines"
{
    PageType = ListPart;

    SourceTable = "R. Shortlisting Criteria";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Stage Code"; "Stage Code")
                {


                }
                field(Criterion; Criterion)
                {
                    Visible = false;
                }
                field("Criterion Description"; "Criterion Description")
                {
                    Visible = false;
                }
                field("Qualification Type"; "Qualification Type")
                {


                }
                field(Qualification; Qualification)
                {

                }
                field("Desired Core"; "Desired Core")
                {

                }
            }
        }
    }
}