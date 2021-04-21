page 51513967 "BDM Role Center"
{
    PageType = RoleCenter;
    Caption = 'Business Development Manager Role Center';
    //SourceTable = "Credit Guarantee Cue";

    layout
    {
        area(RoleCenter)
        {
            group(Column1)
            {
                part(Activities; "BM Activities")
                {
                    Caption = 'Activities';
                }
                part("My Contracts"; "My Contracts")
                {

                }

            }
            group(Column2)
            {
                part(MyCustomers; "My Customers")
                {
                }
                systempart(MyNotifications; MyNotes)
                {
                }
                systempart(Emails; Outlook)
                {

                }
                part(ReportInbox; "Report Inbox Part")
                {
                }
            }

        }
    }

    actions
    {
        area(Embedding)
        {
            action(Applications)
            {
                Caption = 'Guarantee Applications';
                Image = List;
                RunObject = page "Guarantee Application List";
                ToolTip = 'Create guarantee application';
            }
            action(Preappraisal)
            {
                Caption = 'Applications Under Pre-Appraisal';
                Image = List;
                RunObject = page "Application BDO Pre-Appraisal";
            }
            action("Contracts Preparation")
            {
                Caption = 'Applications Under Contract Prepation';
                RunObject = page "Contract Preparation";
            }
            action("Contract Signing")
            {
                Caption = 'Applications Under Contract Signing';
                RunObject = page "Contract Signing";
            }
            action(BPinProgress)
            {
                Caption = 'Business Plan In Progress';
                RunObject = page "Business Plan In Progress";
            }
            action(BPWithBank)
            {
                Caption = 'Business Plan With Banks';
                RunObject = page "Business Plan with Bank";
            }
            action(CGCPreparations)
            {
                Caption = 'CGC Preparations';
                RunObject = page "CGC Preparation";
            }
            action(Contracts)
            {
                Caption = 'Guarantee Contracts';
                Image = List;
                RunObject = page "Guarantee Contracts";
                ToolTip = 'View all guarantee contracts';
            }
            action("LO List")
            {
                Caption = 'Lenders Option Single List';
                RunObject = page "Lenders Option Single List";
            }
            action("Fee WaiverApplications")
            {
                Caption = 'Fee Waiver Applications';
                RunObject = page "Fee Waiver Aapplication List";

            }
        }
        area(Sections)
        {
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
                action("Training List")
                {
                    Caption = 'Training List';
                    Image = Trace;
                    RunObject = page "Training Plan List";
                }
                action("Training Evaluation List-Self")
                {
                    Caption = 'Training Evaluation List';
                    Image = Trace;
                    RunObject = page "Evaluation List";

                }
            }
            group("Claim Management")
            {
                Image = Marketing;
                action("Claim Listing")
                {
                    Caption = 'Claim List';
                    RunObject = page "Claim List";
                }
                action("Closed Claims")
                {
                    Caption = 'Closed Claims List';
                    RunObject = page "Closed Claim List";
                }
            }
            group("Account Schedules")
            {
                Image = AnalysisView;
                action("Account Schedule")
                {
                    Caption = 'Account Schedules';
                    RunObject = page "Account Schedule Names";
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
            action("Import LO Applications")
            {
                Caption = 'Import LO Applications';
                Image = ImportExcel;
                RunObject = page "LO General Journal";
                Promoted = true;
                PromotedCategory = New;
            }
            action("CGC Aging Journal")
            {
                Caption = 'Import Aging Report';
                Image = Import;
                RunObject = page "CGC Aging Journal";
            }
        }
        area(Reporting)
        {
            action("Issued CGC")
            {
                Caption = 'Issued CGC';
                Image = Report;
                RunObject = report "Issued CGC";
                Promoted = true;
                PromotedCategory = Report;
            }
            action("Core Business")
            {
                Caption = 'Core Business';
                Image = Report2;
                RunObject = report "Core Business";
                Promoted = true;
                PromotedCategory = Report;
            }
            action("Loan Aging")
            {
                Caption = 'Loan Aging Report';
                Image = Aging;
                RunObject = report "Loan Aging";
            }
            action("SIDA Report")
            {
                Caption = 'SIDA Report';
                Image = Report2;
                RunObject = report "SIDA Report";
            }
            action("Type of Guarantee and Gender")
            {
                Caption = 'Type of Guarantee and Gender';
                Image = Report2;
                RunObject = report "Guaratee by Gender";
            }
            action("BP Submitted")
            {
                Caption = 'Business Plans Submitted';
                Image = Report2;
                RunObject = report "BP Submitted";
            }
            action("Lenders Option Loans Approved")
            {
                Caption = 'Lenders Option Loans Approved';
                Image = Report2;
                RunObject = report "Lenders Option Loans Approved";
            }
        }
    }

}