page 51513431 "Applicant Card"
{
    PageType = Card;
    SourceTable = "Job Applicants";
    SourceTableView = sorting ("No.") order(descending) where ("Job Function" = filter ("Normal Job"));
    Caption = 'Applicant Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {


                }
                field("Application Date"; "Application Date")
                {


                }
                field("Applicant Type"; "Applicant Type")
                {


                }
                field("Employee No"; "Employee No")
                {


                }
                field("First Name"; "First Name")
                {


                }
                field("Middle Name"; "Middle Name")
                {


                }
                field("Last Name"; "Last Name")
                {


                }
                field("Job ID"; "Job ID")
                {


                }
                field(Initials; Initials)
                {


                }
                field("ID Number"; "ID Number")
                {


                }
                field("Driving Licence"; "Driving Licence")
                {

                }
                field("Passport Number"; "Passport Number")
                {

                }
                field("Voter ID"; "Voter ID")
                {

                }
                field(Gender; Gender)
                {


                }
                field(Citizenship; Citizenship)
                {


                }
                field(Submitted; Submitted)
                {


                }
                field(Employ; Employ)
                {


                }
            }
            group(Personal)
            {
                field(Status; Status)
                {


                }
                field("Marital Status"; "Marital Status")
                {


                }
                field(Nationality; Nationality)
                {

                }
                field("Place of Domicile"; "Place of Domicile")
                {

                }
                field(Disabled; Disabled)
                {


                }
                field("Disability Details"; "Disability Details")
                {
                    MultiLine = true;
                }
                field("Date Of Birth"; "Date Of Birth")
                {


                }
                field(Age; Age)
                {


                }
            }
            group(Communication)
            {
                field("Home Phone Number"; "Home Phone Number")
                {


                }
                field("Cellular Phone Number"; "Cellular Phone Number")
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
                field("Fax Number"; "Fax Number")
                {

                }
                field("Postal Address"; "Postal Address")
                {


                }
                field("Postal Address2"; "Postal Address2")
                {


                }
                field("Postal Address3"; "Postal Address3")
                {


                }
                field("Post Code"; "Post Code")
                {


                }
                field("Post Code2"; "Post Code2")
                {


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

            }

            part(Qualifications; "Applicant Qualification")
            {
                SubPageLink = "Applicant No." = FIELD ("No.");
                Caption = 'Qualifications';
            }




            part("Work Experience"; "Applicant Work Experience")
            {
                SubPageLink = "Applicant No." = FIELD ("No.");
                Caption = 'Work Experience';
            }



            part(Referees; "Applicant Referees")
            {
                SubPageLink = No = FIELD ("No.");
                Caption = 'Referees';
            }



            part(Documents; "Applicant Documents")
            {
                SubPageLink = "Applicant No " = FIELD ("No.");
                Caption = 'Documents';
            }


            part("View/Comments"; "Applicant Comments/Views")
            {
                Caption = 'View/Comments';
            }

        }


    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}