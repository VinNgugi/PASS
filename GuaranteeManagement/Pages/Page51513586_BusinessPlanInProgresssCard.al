page 51513586 "BP In Progresss Card"
{
    Caption = 'BP In Progresss Card';
    PageType = Card;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Guarantee Contracts";
    SourceTableView = sorting("No.") where("Contract Status" = FILTER("BP in Progress"));
    PromotedActionCategories = 'New,Process,Report,Documents,Approve,Request Approval,Navigate,Applicant';

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Application Date"; "Application Date")
                {
                    Editable = false;

                }
                field(Name; Name)
                {

                }

                field(Address; Address)
                {
                    Editable = false;
                }
                field(City; City)
                {
                    Editable = false;
                }
                field(Gender; Gender)
                {
                    Editable = false;
                }
                field("Phone No."; "Phone No.")
                {
                    Editable = false;
                }
                field("E-Mail"; "E-Mail")
                {
                    Editable = false;
                }
                field("Consultancy Fee Invoiced"; "Consultancy Fee Invoiced")
                {
                    Editable = false;
                }
                field("Consultancy Fee Invoice Amount"; "Consultancy Fee Invoice Amount")
                {
                    Editable = false;
                }
                field("Consultancy Fee Paid"; "Consultancy Fee Paid")
                {
                    Editable = false;
                }
                field("Type of Facility"; "Type of Facility")
                {

                }
                field("Loan Amount"; "Loan Amount")
                {

                }
                field("Loan Amount(LCY)"; "Loan Amount(LCY)")
                {
                    Editable = false;
                }
                field("Currency Code"; "Currency Code")
                {

                }
                field("BP Amount"; "BP Amount")
                {

                }
                field("BP Amount LCY"; "BP Amount LCY")
                {
                    Editable = false;
                }
                field("BP Currency"; "BP Currency")
                {

                }
                field(Stage; Stage)
                {
                    Editable = false;
                }
                field("BP Reviewed"; "BP Reviewed")
                {
                    Editable = false;
                }
                field("BP Reviewed By"; "BP Reviewed By")
                {
                    Editable = false;
                }
                field("Quality Assurance"; "Quality Assurance")
                {
                    Editable = false;
                }
                field("QA Done By 1"; "QA Done By 1")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Global Dimension 3 Code"; "Global Dimension 3 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 4 Code"; "Global Dimension 4 Code")
                {
                    Visible = false;
                }

                field("Submit to Bank Date"; "Submit to Bank Date")
                {

                }

                field("Contract Status"; "Contract Status")
                {
                    Editable = false;
                }

            }
            group("Guarantee Details")
            {
                field("Guarantee Source"; "Guarantee Source")
                {

                }
                field("Pct. Guarantee Applied"; "Pct. Guarantee Applied")
                {

                }
                field("PASS Guarantee Amount"; "PASS Guarantee Amount")
                {
                    Editable = false;
                }
                field("SIDA Guarantee Amount"; "SIDA Guarantee Amount")
                {
                    Editable = false;
                }
                field("IFC Guarantee Amount"; "IFC Guarantee Amount")
                {
                    Editable = false;
                }
            }
            part(Banks; Banks)
            {
                SubPageLink = "No." = field("No.");
            }

        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                SubPageLink = "Table ID" = CONST(51513019), "No." = FIELD("No.");
            }
            systempart(Notes; Notes)
            {

            }
            systempart(Links; Links)
            {

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Fee Waiver Aapplication")
            {

                Caption = 'Fee Waiver Application';
                Image = ApplicationWorksheet;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = page "Fee Waiver Application";
                RunPageLink = "Client No." = field("No.");
            }
            action("Business Plan Prepared")
            {
                Caption = 'Business Plan Prepared';
                Image = AvailableToPromise;
                Promoted = true;
                PromotedCategory = Process;

                trigger Onaction()

                begin
                    if Confirm('Is this Business Plan ready for review?', false) then begin
                        StageRec.Reset();
                        StageRec.SetRange(Stage, StageRec.Stage::"Business Plan");
                        StageRec.SetRange(Sequence, 2);
                        if StageRec.FindFirst() then begin
                            Stage := StageRec.Code;
                            "BP sent for review" := true;
                            Message('Successfully submited');
                        end else
                            Error('kindly setup Business Plan stages');
                    end;
                end;
            }

            action("Peer Review Done")
            {
                Caption = 'Peer Review Done';
                Image = ReviewWorksheet;
                Promoted = true;
                PromotedCategory = Process;

                trigger Onaction()

                begin
                    if Confirm('Are you sure you want to submit this Business Plan for Quality Assurance review?', false) then begin
                        StageRec.Reset();
                        StageRec.SetRange(Stage, StageRec.Stage::"Business Plan");
                        StageRec.SetRange(Sequence, 3);
                        if StageRec.FindFirst() then begin
                            Stage := StageRec.Code;
                            "BP Reviewed" := true;
                            "BP Reviewed By" := UserId;
                            Message('Successfully submited');
                        end else
                            Error('kindly setup Business Plan stages');
                    end;
                end;
            }
            action("Quality Assurance Done")
            {
                Caption = 'Quality Assurance Done';
                Image = TaskQualityMeasure;
                Promoted = true;
                PromotedCategory = Process;

                trigger Onaction()

                begin
                    IF Confirm('Are you sure you have done quality assurance?', false) then begin
                        "Quality Assurance" := true;
                        "QA Done By 1" := UserId;
                        Message('Successfully submited');
                    end;

                end;
            }
            action("Submit to Bank")
            {
                Caption = 'Submit to Bank';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    GuaranteeMngt: Codeunit "Guarantee Management";
                    CONF_SUBMIT_TO_BANK: TextConst ENU = 'Do you want to submit contract %1 of %2 to %3?';
                begin
                    TestField("BP Reviewed", true);
                    TestField("Quality Assurance", true);
                    GetAppInv();
                    IF CONFIRM(CONF_SUBMIT_TO_BANK, false, "No.",
                                                               "Loan Amount",
                                                                Bank) THEN begin
                        GuaranteeMngt.SubmitTobank(Rec);
                        "Previous Status" := "Contract Status";
                        "Contract Status" := "Contract Status"::"BP with Bank";
                        Modify;
                        Message('Successfully submited');
                    end;
                end;


            }
            action(Dimensions)
            {
                Caption = 'Dimensions';
                ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                ShortcutKey = 'Shift+Ctrl+D';
                RunObject = page "Default Dimensions";
                RunPageLink = "Table ID" = CONST(51513000), "No." = FIELD("No.");
            }
            action(Attachments)
            {
                ApplicationArea = All;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction();
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GETTABLE(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RUNMODAL;
                end;
            }


        }
    }
    var
        StageRec: Record "Guarantee Application Stages";

    trigger OnOpenPage()

    begin
        GetAppInv();
        Validate("Date of Birth");
    end;


    procedure GetAppInv()
    var
        Appfeeinv: Record "Sales Invoice Header";
        AppfeeInvLines: Record "Sales Invoice Line";
    begin
        if "Consultancy Fee Invoice Amount" = 0 then begin
            Appfeeinv.Reset;
            Appfeeinv.SetRange("Guarantee Application No.", "No.");
            Appfeeinv.SetRange("Guarantee Entry Type", Appfeeinv."Guarantee Entry Type"::Consultancy);
            if Appfeeinv.FindFirst then begin
                AppfeeInvLines.Reset();
                AppfeeInvLines.SetRange("Document No.", Appfeeinv."No.");
                if AppfeeInvLines.FindFirst then begin
                    "Consultancy Fee Invoice Amount" := AppfeeInvLines."Amount Including VAT";
                    Modify();
                end;
            end;
        end;
    end;
}






