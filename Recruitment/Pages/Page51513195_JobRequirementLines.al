page 51513195 "Job Requirement Lines"
{
    PageType = ListPart;
    Caption = 'Job Requirement Lines';
    SourceTable = "Job Requirement";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Job ID"; "Job ID")
                {


                }
                field("Qualification Type"; "Qualification Type")
                {

                }
                field("Qualification Code"; "Qualification Code")
                {

                }
                field(Qualification; Qualification)
                {

                }
                field("Score ID"; "Score ID")
                {

                }
                field(Priority; Priority)
                {

                }
            }
        }
    }
}