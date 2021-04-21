page 51513151 "HR Employee"
{
    // version HR

    SourceTable = Employee;
    Caption = 'HR Employee';

    layout
    {
        area(content)
        {

            group("General Information")
            {
                Caption = 'General Information';
                field("No."; "No.")
                {
                    AssistEdit = true;
                    Editable = true;

                    trigger OnAssistEdit();
                    begin
                        //   IF AssistEdit(xRec) THEN
                        //  CurrPage.UPDATE;
                    end;
                }
                field(Title; Title)
                {
                }
                field("Last Name"; "Last Name")
                {
                    DrillDown = true;
                }
                field("First Name"; "First Name")
                {
                }
                field("Middle Name"; "Middle Name")
                {
                    Caption = 'Other Names';
                }
                field(Initials; Initials)
                {
                }
                field("ID Number"; "ID Number")
                {
                }
                field("Passport Number"; "Passport Number")
                {
                }
                field("Driving Licence"; "Driving Licence")
                {
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                }
                field("Postal Address"; "Postal Address")
                {
                }
                field("Postal Address2"; "Postal Address2")
                {
                    Caption = 'Town';
                }
                field("Postal Address3"; "Postal Address3")
                {
                }
                field("Post Code2"; "Post Code2")
                {
                    Caption = 'Post Code';
                    LookupPageID = "Post Codes";
                }
                field("Residential Address"; "Residential Address")
                {
                }
                field("Residential Address2"; "Residential Address2")
                {
                }
                field("Residential Address3"; "Residential Address3")
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field("Payroll Currency"; "Payroll Currency")
                {
                }
                field("AAR No."; "NHIF No.")
                {
                    Caption = 'AAR No.';
                }

            }
            group(Dimensions)
            {
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    Editable = true;
                    Visible = true;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Editable = true;
                    Visible = true;
                }
                field("Responsibility Center"; "Responsibility Center")
                {

                }
                field("Center Description"; "Center Description")
                {

                }

                /*
                field("Global Dimension 3 Code"; "Global Dimension 3 Code")
                {
                }
                field("Global Dimension 4 Code"; "Global Dimension 4 Code")
                {
                }
                field("Global Dimension 5 Code"; "Global Dimension 5 Code")
                {
                }
                field("Global Dimension 6 Code"; "Global Dimension 6 Code")
                {
                }
                field("Global Dimension 7 Code"; "Global Dimension 7 Code")
                {
                }
                field("Global Dimension 8 Code"; "Global Dimension 8 Code")
                {
                }*/
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';
                field(Gender; Gender)
                {
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                }

                field("Marital Status"; "Marital Status")
                {
                }
                field(Religion; Religion)
                {
                }
                field("No of Dependants"; "No of Dependants")
                {
                }
                field("Spouse Date of Birth"; "Spouse Date of Birth")
                {
                }
                field("Name of Spouse"; "Name of Spouse")
                {

                }
                field("Marriage Date"; "Marriage Date")
                {

                }
                field("Marriage Certificate Attached"; "Marriage Certificate Attached")
                {

                }
                field(County; County)
                {
                }
            }
            group("Job Information")
            {
                Caption = 'Job Information';
                field(Position; Position)
                {
                    Caption = 'Job Position';
                    Visible = true;
                }
                field("Job Title"; "Job Title")
                {
                    Editable = false;
                }
                /*
                field(Level; Level)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Employee Job Type"; "Employee Job Type")
                {
                    Caption = 'Job Type(for Fleet)';
                    Editable = true;
                }*/
                field("Notice Period"; "Notice Period")
                {
                    Caption = 'Notice Period After Confirmation';
                    Editable = false;
                }
            }
            group("Payment Information")
            {
                Caption = 'Payment Information';
                field("PIN Number"; "PIN Number")
                {
                }
                field("P.I.N"; "P.I.N")
                {
                    ShowCaption = true;
                    Visible = false;
                }
                field("NSSF No."; "NSSF No.")
                {
                }

                field("HELB No"; "HELB No")
                {
                }
                field("Co-Operative No"; "Co-Operative No")
                {
                }
                field("Pay Mode"; "Pay Mode")
                {
                }
                field("Posting Group"; "Posting Group")
                {
                    Caption = 'HR Posting Group/Contract Type';
                }
                field("Salary Scale"; "Salary Scale")
                {
                    Caption = 'Grade';
                }
                field(Present; Present)
                {
                }
                field(Previous; Previous)
                {
                    Editable = false;
                }
                field(Halt; Halt)
                {
                    Editable = false;
                }
                field("Imprest Code"; "Imprest Code")
                {

                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';
                field("Date Of Join"; "Date Of Join")
                {
                    Caption = 'Date of Joining Company';
                }
                field("End Of Probation Date"; "End Of Probation Date")
                {
                }
                field(Control35; '')
                {
                }
                field("Retirement Date"; "Retirement Date")
                {
                }
                field("Pension Scheme Join"; "Pension Scheme Join")
                {
                }
                field("Medical Scheme Join"; "Medical Scheme Join")
                {
                }
                field("Date OfJoining Payroll"; "Date OfJoining Payroll")
                {
                }
                field("Base Calendar Code"; "Base Calendar Code")
                {
                }
            }
            group("Contact Numbers")
            {
                Caption = 'Contact Numbers';
                field("Home Phone Number"; "Home Phone Number")
                {
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                }
                field("Fax Number"; "Fax Number")
                {
                }
                field("Work Phone Number"; "Work Phone Number")
                {
                }
                field("Ext."; "Ext.")
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                /*field("Skype ID"; "Skype ID")
                {
                }*/
            }
            group("Contract Information")
            {
                Caption = 'Contract Information';
                field("Full / Part Time"; "Full / Part Time")
                {
                }
                field("Contract Type"; "Contract Type")
                {
                }
                field("Contract Number"; "Contract Number")
                {
                }
                field("Employment Status"; "Employment Status")
                {
                }
                field("Contract Start Date"; "Contract Start Date")
                {
                }
                field("Contract End Date"; "Contract End Date")
                {
                }
                field("Send Alert to"; "Send Alert to")
                {
                }
            }
            group(Separation)
            {
                Caption = 'Separation';
                field("Date Of Leaving"; "Date Of Leaving")
                {
                }
                field("Served Notice Period"; "Served Notice Period")
                {
                }
                field("Termination Category"; "Termination Category")
                {
                }
                field("Grounds for Term. Code"; "Grounds for Term. Code")
                {
                }
                field(Status; Status)
                {
                }
                field("Exit Interview"; "Exit Interview")
                {
                }
                field("Exit Interview Date"; "Exit Interview Date")
                {
                    Editable = false;
                }
                field("Exit Interview Done by"; "Exit Interview Done by")
                {
                }
                field("Allow Re-Employment In Future"; "Allow Re-Employment In Future")
                {
                }
            }

        }
        area(factboxes)
        {
            part(Control1; "Employee Picture")
            {
                ApplicationArea = "#BasicHR";
                SubPageLink = "No." = FIELD ("No.");
                Visible = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Employee Subscriptions")
            {
                Caption = 'Employee Subscriptions';
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
            action("Leave Ledger Entries")
            {
                Caption = 'Leave Ledger Entries';
                Image = LedgerEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "HR Leave Ledger Entries";
                RunPageLink = "Staff No." = field ("No.");
            }
            action("Employee Disciplinary Cases")
            {
                Caption = 'Employee Disciplinary Cases';
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Employee Disciplinary Cases";
                RunPageLink = "Employee No" = field ("No.");
            }
            group("Pay Manager")
            {
                Caption = 'Pay Manager';
                action("Employee Accounts Mapping")
                {
                    Image = Accounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //RunObject = Page "Employee Account Mapping";
                    //RunPageLink = "Employee No." = FIELD ("No.");
                    Visible = false;
                }
            }
            group("Employee's")
            {
                Caption = 'Employee''s';
                group("Employee Details")
                {
                    Caption = 'Employee Details';
                    Image = HumanResources;
                    action("Q&ualifications")
                    {
                        Caption = 'Q&ualifications';
                        RunObject = Page "Emp Qualification";
                        RunPageLink = "No." = FIELD ("No.");
                    }
                    action("Employment History")
                    {
                        Caption = 'Employment History';
                        RunObject = Page "Employment History";
                        RunPageLink = "No." = FIELD ("No.");
                    }
                    action("Employee Responsibilities")
                    {
                        Caption = 'Employee Responsibilities';
                        RunObject = Page "J. Responsiblities";
                        RunPageLink = "Job ID" = FIELD (Position);
                    }
                    separator(Separator129)
                    {
                        Caption = '""';
                    }
                    action("Employee Appointment Checklist")
                    {
                        Caption = 'Employee Appointment Checklist';
                        RunObject = Page "Appointment Checklist";
                        RunPageLink = "Employee No." = FIELD ("No.");
                    }
                    separator(Separator127)
                    {
                        Caption = '""';
                    }
                    action(Terminate)
                    {
                        Caption = 'Terminate';

                        trigger OnAction();
                        begin
                            Status := Status::Terminated;
                            MODIFY;
                        end;
                    }
                    separator(Separator125)
                    {
                        Caption = '""';
                    }
                    action(Action124)
                    {
                        Caption = 'Employee Responsibilities';
                        RunObject = Page "Employee Responsibilities";
                        RunPageLink = "No." = FIELD ("No.");
                        Visible = false;
                    }
                    separator(Separator123)
                    {
                    }
                    action("Emergency Contacts")
                    {
                        Caption = 'Emergency Contacts';
                        RunObject = Page "Employee Emergency Contacts";
                        RunPageLink = "No." = FIELD ("No.");
                    }
                    action("Alternative Addresses")
                    {
                        Caption = 'Alternative Addresses';
                        RunObject = Page "Employee Aternative Addresses";
                        RunPageLink = "No." = FIELD ("No.");
                    }
                    action("Next Of Kin")
                    {
                        Caption = 'Next Of Kin';
                        RunObject = Page "Employee Kin";
                        RunPageLink = "No." = FIELD ("No.");
                    }
                    action(Dependants)
                    {
                        Caption = 'Dependants';
                        RunObject = Page "Employee Dependants";
                        RunPageLink = "No." = FIELD ("No.");
                    }
                    separator(Separator118)
                    {
                    }
                    action("Misc. Article Information")
                    {
                        Caption = 'Misc. Article Information';
                        RunObject = Page "Misc. Article Info.";
                        RunPageLink = "No." = FIELD ("No.");
                    }
                    action("Medical Info.")
                    {
                        Caption = 'Medical Info.';
                        RunObject = Page "Employee Medical Information";
                        RunPageLink = "No." = FIELD ("No.");
                    }
                    separator(Separator115)
                    {
                    }
                    action(Unions)
                    {
                        Caption = 'Unions';
                        RunObject = Page Unions;
                        RunPageLink = Code = FIELD ("No.");
                    }
                    separator(Separator113)
                    {
                    }
                    action("Linked Documents")
                    {
                        Caption = 'Linked Documents';
                        RunObject = Page "Employee Linked Docs";
                        RunPageLink = "No." = FIELD ("No.");
                    }
                    separator(Separator89)
                    {
                    }
                    action("A&bsences")
                    {
                        Caption = 'A&bsences';
                        RunObject = Page "Capacity Absence";
                        //RunPageLink = "Capacity Type" = FIELD ("No.");
                    }
                    separator(Separator83)
                    {
                    }
                    action("Succesion Planning & Requirements")
                    {
                        Caption = 'Succesion Planning & Requirements';
                        RunObject = Page "Succesion Planning";
                        RunPageLink = "No." = FIELD ("No.");
                    }
                    action(" Employee Transfer History")
                    {
                        Caption = 'Employee Transfer History';
                        RunObject = Page "Employee Transfer History";
                        RunPageLink = "Employee No." = FIELD ("No.");
                    }
                    separator(Separator63)
                    {
                    }
                    action("Absences by Ca&tegories")
                    {
                        Caption = 'Absences by Ca&tegories';
                        RunObject = Page "Empl. Absences by Categories";
                    }
                    action("Misc. Articles &Overview")
                    {
                        Caption = 'Misc. Articles &Overview';
                        RunObject = Page "Misc. Articles Overview";
                    }
                    separator(Separator57)
                    {
                    }
                    separator(Separator37)
                    {
                    }
                    action("Separation Details")
                    {
                        Caption = 'Separation Details';
                        RunObject = Page "Separtion Lines";
                        RunPageLink = "Employee No" = FIELD ("No.");
                    }
                    separator(Separator31)
                    {
                    }
                    action("Membership Subscription")
                    {
                        Caption = 'Membership Subscription';
                        RunObject = Page "Employee Profess Subscriptions";
                        RunPageLink = Employee = FIELD ("No.");
                    }
                    action("<Action1000000159>")
                    {
                        Caption = 'Employee List (All Employees)';
                        RunObject = Page "Employee List";
                        RunPageLink = "No." = FIELD ("No.");
                        Visible = false;
                    }
                    action("Employee Detail Summary View (Card)")
                    {
                        Caption = 'Employee Detail Summary View (Card)';
                        Enabled = false;
                        Visible = false;
                    }
                    separator(Separator26)
                    {
                    }
                }
            }
        }
    }
}

