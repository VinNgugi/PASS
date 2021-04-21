page 51513002 "Guarantee App Financial Info"
{
    caption = 'Guarantee Applicant Financial Information';
    PageType = ListPart;
    SourceTable = "Guarantee App Financial Info";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Application No."; "Application No.")
                {
                    Visible = false;
                }
                field("Line No."; "Line No.")
                {
                    Visible = false;
                }
                field("Financial Year Starting"; "Financial Year Starting")
                {

                }
                field("Financial Year Ending"; "Financial Year Ending")
                {

                }
                field("Gross Income"; "Gross Income")
                {


                }
                field("Profit Before Tax"; "Profit Before Tax")
                {


                }
                field("Total Assets"; "Total Assets")
                {


                }
                field("Total Production"; "Total Production")
                {

                }
                field("Unit of Measure"; "Unit of Measure")
                {

                }
                field("No. of Female Employees"; "No. of Female Employees")
                {

                }
                field("No. of Male Employees"; "No. of Male Employees")
                {

                }
                field("No. of Employments Created"; "No. of Employments Created")
                {

                }

                field("No. of Female Beneficiaries"; "No. of Female Beneficiaries")
                {

                }
                field("No. of Male Beneficiaries"; "No. of Male Beneficiaries")
                {

                }
                field("Total No. of Beneficiaries"; "Total No. of Beneficiaries")
                {

                }
            }
        }
    }


}