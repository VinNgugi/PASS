report 51513188 "Appraisal Objectives"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Employee Appraisal Objectives';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Employee Appraisal Objectives.rdl';
    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = sorting ("Primary Key");

            column(Name_; Name)
            {

            }
            column(Picture; Picture)
            {

            }
            column(E_Mail; "E-Mail")
            {

            }
            column(Home_Page; "Home Page")
            {

            }
            column(Address; Address)
            {

            }
            column(Phone_No_; "Phone No.")
            {

            }
            dataitem("Employee Appraisal Objectives"; "Employee Appraisal Objectives")

            {
                column(Appraisee_Name; "Appraisee Name")
                {

                }
                column(Appraisee_s_Job_Title; "Appraisee's Job Title")
                {

                }
                column(Department_Name; "Department Name")
                {

                }
                column(Appraisers_Name; "Appraisers Name")
                {

                }
                column(Appraiser_s_Job_Title; "Appraiser's Job Title")
                {

                }
                column(Appraisal_Period; "Appraisal Period")
                {

                }

                dataitem(Finacial; "Appraisal Objectives Lines")

                {
                    DataItemLink = "Appraisal No" = field ("Objective No");
                    column(Objective; Objective)
                    {

                    }
                    column(Strategic_Perspective; "Strategic Perspective")
                    {

                    }
                    column(Line_No; "Line No")
                    {

                    }

                    dataitem(FinancailMeasure; "Objectives Measures")
                    {
                        DataItemLink = "Appraisal No" = FIELD ("Appraisal No"), "ObjectiveID" = field ("Line No");


                        column(Measure_Description; "Measure Description")
                        {

                        }
                        column(Five_Year_Targets; "Five-Year Targets")
                        {

                        }
                        column(Targets; Targets)
                        {

                        }
                        column(Appraisal_Period_Target; "Appraisal Period Target")
                        {

                        }
                        column(Appraisal_Period_Actuals; "Appraisal Period Actuals")
                        {

                        }
                        column(Initiatives; Initiatives)
                        {

                        }
                        column(Performance_Ratings; "Performance Ratings")
                        {

                        }
                        column(Weighting___; "Weighting(%)")
                        {

                        }
                        column(Weighted_Ratings; "Weighted Ratings")
                        {

                        }
                        column(ObjectiveID; ObjectiveID)
                        {

                        }


                    }

                }
            }
        }
    }







}