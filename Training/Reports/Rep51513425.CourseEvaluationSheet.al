report 51513428 "Course Evaluation Sheet"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Course Evaluation Sheet.rdl';
    Caption = 'Course Evaluation Sheet';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Name; Name)
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
            column(VAT_Registration_No_; "VAT Registration No.")
            {

            }
            dataitem(TrainingEvaluationH; "Training Evaluation H")
            {
                column(No; "No.")
                {
                }
                column(EmployeeNo; "Employee No")
                {
                }
                column(EmployeeName; "Employee Name")
                {
                }
                column(ProviderName; "Provider Name")
                {
                }
                column(TrainerName; "Trainer Name")
                {
                }
                column(TrainingDescription; "Training Description")
                {
                }
                column(TrainingNo; "Training No.")
                {
                }
                column(TrainingProvider; "Training Provider")
                {
                }
                dataitem("Training Evaluation Line"; "Training Evaluation Line")
                {
                    DataItemTableView = sorting ("Header No.", "Evaluation Area");
                    DataItemLink = "Header No." = field ("No.");
                    column(Header_No_; "Header No.")
                    {

                    }
                    column(Evaluation_Area; "Evaluation Area")
                    {

                    }
                    column(Evaluation_Question; "Evaluation Question")
                    {

                    }
                    column(Evaluation_Option; "Evaluation Option")
                    {

                    }
                    column(Evaluation_Points; "Evaluation Points")
                    {

                    }

                    trigger OnPredataItem()
                    var
                        myInt: Integer;
                    begin

                    end;

                    trigger OnAfterGetRecord()
                    var
                        myInt: Integer;
                    begin

                    end;

                    trigger OnPostDataItem()
                    var
                        myInt: Integer;
                    begin

                    end;
                }
                trigger OnPredataItem()
                var
                    myInt: Integer;
                begin

                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

                end;

                trigger OnPostDataItem()
                var
                    myInt: Integer;
                begin

                end;
            }
            trigger OnPredataItem()
            var
                myInt: Integer;
            begin
                "Company Information".CalcFields(Picture)
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
