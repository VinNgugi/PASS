page 51513224 "Employee Appraisals List"
{
    PageType = List;
    Editable = false;
    SourceTable = "Employee Appraisals";
    CardPageId = "Appraisal Form";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Appraisal No"; "Appraisal No")
                {

                }
                field("Appraisal Category"; "Appraisal Category")
                {

                }
                field("Appraisal Period"; "Appraisal Period")
                {

                }
                field("Appraisal Type"; "Appraisal Type")
                {

                }
                field(Status; Status)
                {

                }
                field(Date; Date)
                {

                }
                field(Rating; Rating)
                {

                }
                field("Rating Description"; "Rating Description")
                {

                }
                field("Appraiser No"; "Appraiser No")
                {

                }
                field("Appraisers Name"; "Appraisers Name")
                {

                }
                field("Appraiser ID"; "Appraiser ID")
                {

                }
                field("Appraiser's Job Title"; "Appraiser's Job Title")
                {

                }
                field("Employee No"; "Employee No")
                {

                }
                field("Appraisee Name"; "Appraisee Name")
                {

                }
                field("Appraisee ID"; "Appraisee ID")
                {

                }
                field("Job ID"; "Job ID")
                {

                }
                field("Appraisee's Job Title"; "Appraisee's Job Title")
                {

                }
                field("Deapartment Code"; "Deapartment Code")
                {

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
}