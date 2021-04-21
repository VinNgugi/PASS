page 51513369 "Medical Claim Header"
{
    // version HR

    // // NameDataTypeSubtypeLength ImportClaimsXMLportXMLport51511005

    Editable = true;
    PageType = Card;
    SourceTable = "Medical Claim Header";
    Caption = 'Medical Claim Header';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Claim No"; "Claim No")
                {
                }
                field("Claim Date"; "Claim Date")
                {
                    NotBlank = true;
                }
                field("Service Provider"; "Service Provider")
                {
                    NotBlank = true;
                }
                field("Service Provider Name"; "Service Provider Name")
                {
                    NotBlank = true;
                }
                field(Amount; Amount)
                {
                    NotBlank = true;
                }
                field(Settled; Settled)
                {
                }
                field("Cheque No"; "Cheque No")
                {
                }
                field(Claimant; Claimant)
                {
                }
                field("Fiscal Year"; "Fiscal Year")
                {
                    Editable = false;
                }
                field(Status; Status)
                {
                }
                field("No. of Approvals"; "No. of Approvals")
                {
                }
            }
            part(Control1000000010; "Claim Lines")
            {
                SubPageLink = "Claim No" = FIELD ("Claim No");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Import)
            {
                Caption = 'Import';
                action("Import Claim Lines")
                {
                    Caption = 'Import Claim Lines';

                    trigger OnAction();
                    begin
                        //ImportClaims.RUN;
                    end;
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction();
                    begin
                        //IF ApprovalMgt.SendMedClaimApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';

                    trigger OnAction();
                    begin
                        //IF ApprovalMgt.CancelMedClaimApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Claimant := Claimant::"Service Provider";
    end;

    var
        HRSetup: Record "Human Resources Setup";
        Link: Text[250];
        ApprovalMgt: Codeunit "Approvals Mgmt.";
}

