page 51513099 "Payroll Approval"
{
    // version PAYROLL

    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Payroll Period";
    Caption = 'Payroll Approval';

    layout
    {
        area(content)
        {
            field("Starting Date"; "Starting Date")
            {
                Editable = true;
            }
            field(Name; Name)
            {
                Editable = false;
            }
            repeater(Approvers)
            {
                Caption = 'Approvers';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                field("Approvername[1]"; Approvername[1])
                {
                }
                field("Approver 1"; "Approver 1")
                {
                    Caption = '.';
                }
                field("Approvername[2]"; Approvername[2])
                {
                }
                field("Approver 2"; "Approver 2")
                {
                    Caption = '.';
                }
                field("Approvername[3]"; Approvername[3])
                {
                }
                field("Approver 3"; "Approver 3")
                {
                    Caption = '.';
                }
                field("Approvername[4]"; Approvername[4])
                {
                }
                field("Approver 4"; "Approver 4")
                {
                    Caption = '.';
                }
                field("Approvername[5]"; Approvername[5])
                {
                }
                field("Approver 5"; "Approver 5")
                {
                    Caption = '.';
                }
                field("Approvername[6]"; Approvername[6])
                {
                }
                field("Approver 6"; "Approver 6")
                {
                    Caption = '.';
                }
                field("Approvername[7]"; Approvername[7])
                {
                }
                field("Approver 7"; "Approver 7")
                {
                    Caption = '.';
                }
            }
            field(Status; Status)
            {
                Editable = false;
            }
            field("Approval Status"; "Approval Status")
            {
                Editable = false;
            }
        }
    }

    actions
    {
        area(creation)
        {
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        //SETFILTER("Starting Date",'%1',"Starting Date");
        //CurrPage.UPDATE;
    end;

    trigger OnOpenPage();
    begin
        /*hideapproval:=TRUE;
        addrec.RESET;
        addrec.SETFILTER(addrec."Document Type",'%1',addrec."Document Type"::Payroll);
        IF addrec.FINDSET THEN REPEAT
        i+=1;
        Approvername[i]:=addrec."Approver ID"; //message('%1', Approvername[i]);
            IF USERID=Approvername[i] THEN BEGIN
               hideapproval:=FALSE;
            END;
        UNTIL addrec.NEXT=0;
        //CurrPage.UPDATE;
        
        
        //=======================================================================
          IF hideapproval=FALSE THEN BEGIN
              ApproveVisible:=TRUE;
              RejectVisible:=TRUE;
          END;
          IF hideapproval=TRUE THEN BEGIN
              ApproveVisible:=FALSE;
              RejectVisible:=FALSE;
          END;
        
        //=======================================================================
         SETFILTER("Starting Date",'%1',"Starting Date");
         */

    end;

    var
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        testtxt: Text;
        Approvername: array[10] of Text;
        i: Integer;
        hideapproval: Boolean;
        ApprovalEntry: Record "Approval Entry";
        [InDataSet]
        ApproveVisible: Boolean;
        [InDataSet]
        RejectVisible: Boolean;
        Text001: Label 'You can only delegate open approval entries.';
        Text002: Label '"The selected approval(s) have been delegated. "';
        Text004: Label 'Approval Setup not found.';
        Usersetup: Record "User Setup";
}

