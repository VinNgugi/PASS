page 51513805 "AIC Applicant Card"
{
    PageType = Card;
    SourceTable = "Incubation Applicants";
    SourceTableView = sorting ("No.") order(ascending);
    Caption = 'AIC Applicant Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = (NOT Submitted);
                field("No."; "No.")
                {


                }
                field("Application Date"; "Application Date")
                {
                    Editable = false;
                }
                field(Name; Name)
                {

                }

                field("Incubation Code"; "Incubation Code")
                {

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        // AICMgmt.PopulateQuestionnaireEntriesForApplicant(Rec);
                    end;
                }
                field("Incubation Name"; "Incubation Name")
                {

                }

                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }

                field(Gender; Gender)
                {

                }
                field("Receipt No."; "Receipt No.")
                {

                }

                field(Submitted; Submitted)
                {
                    //Editable = false;
                }
            }
            group(Personal)
            {
                Editable = (NOT Submitted);
                field("Marital Status"; "Marital Status")
                {

                }

                field("Date Of Birth"; "Date Of Birth")
                {

                }
                field(Age; Age)
                {

                }
                field("Education Level"; "Education Level")
                {

                }
                field("Years of Experience in Farming"; "Years of Experience in Farming")
                {

                }
                field("Experience in Agri-business"; "Experience in Agri-business")
                {

                }
                field("Agri-business involved?"; "Agri-business involved?")
                {

                }
                field("Why to be part of Incubation?"; "Why to be part of Incubation?")
                {
                    MultiLine = true;
                }
            }
            group(Communication)
            {
                Editable = (NOT Submitted);
                field("Phone Number"; "Phone Number")
                {

                }

                field("E-Mail"; "E-Mail")
                {
                    trigger OnValidate()
                    begin
                        SetRange("E-Mail", "E-Mail");
                        SetRange("Incubation Code", "Incubation Code");
                        if FindFirst() then
                            Error('You have already applied for %1', "Incubation Name");
                    end;
                }


                field(Address; Address)
                {

                }
                field("Address 2"; "Address 2")
                {

                }
                field("Post Code"; "Post Code")
                {

                }


            }



            /* part(AppicantQuestionnaire; "Applicant Questionnaire")
             {
                 Editable = (NOT Submitted);
                 Caption = 'Applicant Questionnaire';
                 SubPageLink = "Applicant No" = field("No.");
             }
             part(EnterprenuershipTest; "Enterprenuership Test Entry")
             {
                 Editable = (NOT Submitted);
                 Caption = 'Enterprenuership Test';
                 SubPageLink = "Application ID" = field("No.");
             }*/


        }


    }

    actions
    {
        area(Processing)
        {
            action("Submit Application")
            {
                Caption = 'Submit Application';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = (NOT Submitted);

                trigger OnAction()

                begin
                    AICMgmt.SubmitApplication(Rec);
                end;
            }
        }
    }

    trigger OnOpenPage()

    begin

    end;

    trigger OnNewRecord(BelowRec: Boolean)
    var

    begin

        "Application Date" := Today;

    end;

    trigger OnAfterGetRecord()

    begin

    end;


    trigger OnAfterGetCurrRecord()
    var

    begin

        /*EditableData := true;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist := TRUE;
        IF Status = Status::Released then begin
            OpenApprovalEntriesExist := FALSE;
            CanCancelApprovalForRecord := FALSE;
            EnabledApprovalWorkflowsExist := FALSE;
            EditableData := false;
        end;

        if Status <> Status::Open then begin
            CurrPage.Editable := false;
            EditableData := false;
        end;*/


    end;


    var
        AICMgmt: Codeunit "AIC Management";



}