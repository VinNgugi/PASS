page 51513961 "Human Resource Role Centre"
{
    PageType = RoleCenter;
    Caption = 'Human Resource Role Centre';
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Navigate,Applicant';
    layout
    {
        area(RoleCenter)
        {
            group(column1)
            {
                part(Employees; "HR Employee Cue")
                {
                    Caption = 'Activities';
                }
                part("Favorite Accounts"; "My Accounts")
                {

                }
            }
            group(column2)
            {
                systempart(MyNotifications; MyNotes)
                {
                }
                systempart(Emails; Outlook)
                {

                }
            }

        }
    }

    actions
    {
        area(Embedding)
        {
            action("Employees List")
            {
                Caption = 'Employee List';
                Image = List;
                RunObject = page "HR Employee List";

            }
        }
        area(Sections)
        {
            group(Recruitment)
            {
                Image = ResourcePlanning;
                action("Recruitment Requisistions")
                {
                    Caption = 'Recruitment Requisitions';
                    image = NewOrder;
                    RunObject = page "Recruitment Needs";
                }
                action("Job Applications List")
                {
                    Caption = 'Job Applications List';
                    Image = List;
                    RunObject = page "Applicants List";
                }
                action("ShortListing Criteria List")
                {
                    Caption = 'Shortlisting Criteria list';
                    RunObject = page "Shortlisting Criteria List";
                }
                action("Shortlisting")
                {
                    Caption = 'Shortlisting';
                    Image = ListPage;
                    RunObject = page Shortlisting;
                }
                action("Advertisements")
                {
                    Caption = 'Job Advertisements';
                    Image = ListPage;
                    RunObject = page Advertisements;
                }
                action("Vacant Establishments")
                {
                    Caption = 'Vacant Establishments';
                    Image = ListPage;
                    RunObject = page "Vacant Establishments";
                }
                action("Over Staffed Establishments")
                {
                    Caption = 'Over Staffed Establishments';
                    Image = ListPage;
                    RunObject = page "Over Staffed Establishments";
                }

            }
            group("Employee Manager")
            {
                Image = Marketing;
                action("Employee List")
                {
                    Caption = 'Employee List';
                    RunObject = page "HR Employee List";
                }
                action("Employee Contracts")
                {
                    Caption = 'Employee Contracts';
                    RunObject = page "Employee Contracts List";
                }
                action("Employee Qualifications")
                {
                    Caption = 'Employee Qualificatios';
                    RunObject = page "Employee Qualifications List";
                }
                action("Medical Scheme")
                {
                    Caption = 'Medical Scheme List';
                    RunObject = page "Medical Scheme Header List";
                }
                action("Medical Claim")
                {
                    Caption = 'Medical Claim List';
                    RunObject = page "Medical Claim Header List";
                }
            }
            group("Leave Management")
            {
                Image = CostAccounting;

                action("Employee Leave Applications")
                {
                    Caption = 'Imployee Leave Applications';
                    RunObject = page "Emplo Leave Application List";
                }
                action("Leave Recalls")
                {
                    Caption = 'Imployee Leave Recalls';
                    RunObject = page "Leave Recalls List";
                }
            }
            group("Disciplinary Cases")
            {
                Image = Capacities;
                action("Disciplinary")
                {
                    Caption = 'Disciplinary Cases';
                    RunObject = page "Disciplinary Cases";
                }
                action("Ongoing Cases")
                {
                    Caption = 'Ongoing Cases';
                    RunObject = page "Ongoing Cases";
                }
                action("Appealed Cases")
                {
                    Caption = 'Appealed Cases';
                    RunObject = page "Appealed Cases";
                }
                action("Closed Cases")
                {
                    Caption = 'Closed Cases';
                    RunObject = page "Closed Cases";
                }
                action("Court Cases")
                {
                    Caption = 'Court Cases';
                    RunObject = page "Court Cases";
                }
            }

            group(Training)
            {
                Image = CashFlow;
                action("Training Plan List")
                {
                    Caption = 'Training Plan List';
                    RunObject = page "Training Plan List";
                }
                /*action("Consolidate Training Plan List")
                {
                    Caption = 'Consolidate Training Plan List';
                    RunObject = page "Consolidate Training Plan List";
                }*/
            }

            group(Payroll)
            {
                Image = Payroll;
                action("Payroll Employee List")
                {
                    Caption = 'Payroll Employee List';
                    RunObject = page "Employee List";
                }
                action("Pay Periods")
                {
                    Caption = 'Pay Periods';
                    RunObject = page "Pay Periods";
                }
                action("Bracket Tables")
                {
                    Caption = 'Bracket Tables';
                    RunObject = page "Bracket Tables";
                }
                action("Salary Scale List")
                {
                    RunObject = page "Salary Scales List";

                }
                action("Salary Pointers")
                {
                    RunObject = page "Salary Pointers";
                }
                action(Institutions)
                {
                    RunObject = page Insitutions;
                }
                action("Scale Benefits")
                {
                    RunObject = page "Scale Benefits";
                }
                action("Staff Posting Groups")
                {
                    RunObject = page "Staff Posting Group";
                }
                action("Overtime Setup")
                {
                    RunObject = page "Overtime Set Up";
                }
                action("Dependants Bands")
                {
                    RunObject = page "Dependants Bands";
                }
                action("Tax Relief SetUp")
                {
                    RunObject = page "Tax Relief List";
                }
                action("Payroll Subcategories")
                {
                    RunObject = page "Payroll Subcategories";
                }
                action("Payroll Batches")
                {
                    RunObject = page "Payroll Batches";
                }
            }

            group("Self Service")
            {
                Caption = 'Self-Service';
                Image = HumanResources;
                action("Petty Cash")
                {
                    Caption = 'Petty cash';
                    Image = PeriodEntries;
                    RunObject = page "PettyCash List";
                    ToolTip = 'Create petty cash request';
                }
                action("Travel Memo")
                {
                    Caption = 'Memo Creation';
                    Image = PeriodEntries;
                    RunObject = page "Memo List";
                    ToolTip = 'Create a Memo';
                }
                action("Hotel Application")
                {
                    Caption = 'Hotel Application';
                    Image = PeriodEntries;
                    RunObject = page "Hotel Application List";
                    ToolTip = 'Create a Hotel Application';
                }
                action("Imprest Requisition")
                {
                    Caption = 'Imprest Requisition';
                    Image = PeriodEntries;
                    RunObject = page "Imprest Requisition List";
                    ToolTip = 'Create impret request';
                }
                action("Imprest Surrender")
                {
                    Caption = 'Imprest Surrender';
                    Image = PeriodEntries;
                    RunObject = page "Imprest Surrender List";
                    ToolTip = 'Create impret surrender';
                }

                action("Purchase Requisition")
                {
                    Caption = 'Purchase Requision';
                    Image = PeriodEntries;
                    RunObject = page "Purchase Requisitions List";
                    ToolTip = 'Create purchase request';
                }
                action("Leave Application")
                {
                    Caption = 'Leave Application';
                    Image = ApplicationWorksheet;
                    RunObject = page "Leave Applications List";
                    ToolTip = 'Create leave application';
                }

                action("Training Evaluation List-Self")
                {
                    Caption = 'Training Evaluation List';
                    Image = Trace;
                    RunObject = page "Evaluation List";

                }
            }

            group(Administration)
            {
                Image = HRSetup;

                group("Employee Setups")
                {

                    action("Company Jobs")
                    {
                        Caption = 'Company Jobs';
                        Image = Job;
                        RunObject = page "Company Job List";
                    }
                    action("Salary Scales")
                    {
                        Caption = 'Salary Scales';
                        Image = Salutation;
                        RunObject = page "Salary Scales List";
                    }

                    action("Score Setup")
                    {
                        Caption = 'Score Setup';
                        Image = Setup;
                        RunObject = page "Score Setup List";
                        ;
                    }
                    action("Recruitment Stages")
                    {
                        Caption = 'Recruitment Stages';
                        Image = Setup;
                        RunObject = page "Recruitment Stages";
                    }
                    action("Professional Bodies")
                    {
                        Caption = 'Professional Bodies';
                        Image = ProfileCalendar;
                        RunObject = page "Professional Bodies";
                    }
                    action("Ethnic Groups")
                    {
                        Caption = 'Ethnic Groups';
                        Image = Setup;
                        RunObject = page "Ethnic Groups List";
                    }
                    action("Shortlisting Criaterion")
                    {
                        Caption = 'Shortlisting Criaterion';
                        Image = Setup;
                        RunObject = page "Shortlisting Criterion";
                    }
                    action("Relatives")
                    {
                        Caption = 'HR Relative';
                        RunObject = page "HR Relative";

                    }
                    action(Qualifications)
                    {
                        Caption = 'Qualifications';
                        RunObject = page Qualifications;
                    }
                }
                group("Leave Setups")
                {
                    action("Leave Types")
                    {
                        caption = 'Leave Types Setup';
                        RunObject = page "Leave Types Setup";
                    }
                    action("Leave Periods")
                    {
                        caption = 'Leave Periods';
                        RunObject = page "HR Leave Period List";
                    }
                }

                group("Disciplinary Setup")
                {

                    action("Disciplinary Actions ")
                    {
                        Caption = 'Disciplinary Actions ';
                        RunObject = page "Disciplinary Actions";
                    }
                    action("Disciplinary Offenses")
                    {
                        Caption = 'Disciplinary Offenses';
                        RunObject = page "Disciplinary Offenses";
                    }
                    action("Committee Board Of Directors")
                    {
                        Caption = 'Committee Board Of Directors';
                        RunObject = page "Committee Board Of Directors";
                    }
                    action("Levels of Discipline List")
                    {
                        Caption = 'Levels of Discipline List';
                        RunObject = page "Levels of Discipline List";
                    }
                }
                group("PayrollSetup")
                {
                    action(Earnings)
                    {
                        RunObject = page Earnings;
                    }
                    action(Deductions)
                    {
                        RunObject = page Deductions;
                    }
                    action("Payroll Bank List")
                    {
                        RunObject = page "Payroll Bank List";
                    }
                }
            }
            group("Performance Management")
            {
                Image = HumanResources;
                action("Employee Appraisals List")
                {
                    Caption = 'Employee Appraisals List';
                    RunObject = page "Employee Appraisals List";

                }
                action("Appraisal Objectives List")
                {
                    Caption = 'Appraisal Objectives List';
                    RunObject = page "Appraisal Objectives List";
                }
            }
        }

        area(Processing)
        {
            group("Payroll Periodic Activities")
            {
                action("Import Overtime")
                {
                    RunObject = page "Import Overtime";
                    Image = Import;
                }
                action("Effected Salary Increament")
                {
                    RunObject = page "Effected Salary Increament";
                    Image = PeriodEntries;
                }
                action("Leave Allowance to Payroll")
                {
                    RunObject = report "Leave Allowance to Payroll";
                    Image = TransferFunds;
                }

                action("Payroll Run")
                {
                    RunObject = report "Payroll Run";
                    Image = Payroll;
                }
                action("Transfer to Journal")
                {
                    RunObject = report "Transfer to Journal";
                    Image = TransferFunds;
                }
                action("Transfer Payroll(Individual)")
                {
                    RunObject = report "Transfer Payroll Individual";
                    Image = TransferToLines;

                }
                action("Close Pay Period")
                {
                    RunObject = report "Close Pay period";
                    Image = ClosePeriod;
                }
                action("Bank File")
                {
                    Image = Report;
                    RunObject = report "Salary EFT";
                }

            }

        }
        area(Reporting)
        {
            group("Payroll Reports")
            {
                Caption = 'Payroll Reports';
                group("Management Reports")
                {
                    action("Earnings Report")
                    {
                        RunObject = report Earnings;
                        Image = Report;
                    }
                    action("Master Roll Report")
                    {
                        RunObject = report "Master Roll New Report";
                        Image = Report;
                    }
                    action("Company Payslip")
                    {
                        RunObject = report "Company Payslip1";
                        Image = Report;
                    }
                    action("Sacco Deductions Report")
                    {
                        RunObject = report "Sacco Deductions";
                        Image = Report;
                    }

                    action("Negative Pay")
                    {
                        RunObject = report "Negative Pay";
                        Image = NegativeLines;
                    }

                    action("Non Pensionable Employees")
                    {
                        Image = Report2;
                        RunObject = report "Non Pensionable Employees";
                    }
                    action("Net Pay Report")
                    {
                        Image = Payment;
                        RunObject = report "Net Pay Report";
                    }
                }
                group("Reconciliation Reports")
                {
                    action("Reconciliation Report")
                    {
                        RunObject = report "Reconciliation Summary";
                        Image = Report;
                    }
                    action("Detailed ED Report")
                    {
                        RunObject = report "Master Report";
                        Image = Report2;
                    }
                    action("New Employees")
                    {
                        Image = Report;
                        RunObject = report "New Employees";
                    }
                    action("Employees Removed From Payroll")
                    {
                        Image = Report;
                        RunObject = report "Employees Removed";
                    }
                }
                group("Statutory Reports")
                {
                    action("Pension Report")
                    {
                        Image = Report2;
                        RunObject = report "Pension Report";
                    }
                    action("WCF Report")
                    {
                        Image = Report;
                        RunObject = report "WCF Report";
                    }
                    action("NSSF report")
                    {
                        Image = Report;
                        RunObject = report "NSSF Reporting";
                    }
                    action("P10 Report")
                    {
                        Image = Report;
                        RunObject = report "Employer P10 Report";
                    }
                    action("HELSB Report")
                    {
                        Image = Report;
                        RunObject = report "Helb Report";
                    }
                }
            }
            group("Leave Reports")
            {
                Image = Loaner;
                action("Staff on Leave")
                {
                    Caption = 'Staff on Leave';
                    RunObject = report "Staff On Leave";
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                }
                action("Leave Recall List")
                {
                    Caption = 'Leave Recall List';
                    RunObject = report "Leave Recall List";
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                }
                action("Leave Application Report")
                {
                    Caption = 'Leave Applications';
                    RunObject = report "Leave Application Report";
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                }
                action("Leave Balances")
                {
                    Caption = 'Leave Balances';
                    RunObject = report "Leave Balances Report";
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                }
                action("Annual Leave Balances")
                {
                    Image = Report;
                    RunObject = report "Leave Balances";
                }
            }
            group("Employees Reports")
            {
                action("Employee-List")
                {
                    RunObject = report "Employee - List";
                    Image = Employee;
                }
                action("Employee Manpower Report")
                {
                    Image = Report;
                    RunObject = report "Employee Manpower Report";
                }
                action("Employee Bank accounts")
                {
                    Image = Report;
                    RunObject = report "Employee Bank Accounts";
                }
            }
        }
    }

    var
        myInt: Integer;
}