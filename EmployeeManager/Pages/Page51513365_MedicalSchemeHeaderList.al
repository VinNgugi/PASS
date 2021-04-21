page 51513365 "Medical Scheme Header List"
{
    // version HR

    CardPageID = "Medical scheme Header";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Medical Scheme Header";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("No."; "No.")
                {
                }
                field("Selection Date"; "Selection Date")
                {
                }
                field("Cover Type"; "Cover Type")
                {
                }
                field("Policy No"; "Policy No")
                {
                }
                field("Policy Start Date"; "Policy Start Date")
                {
                }
                field("Policy Expiry Date"; "Policy Expiry Date")
                {
                }
                field("Employee No"; "Employee No")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                }
                field("Entitlement -Inpatient"; "Entitlement -Inpatient")
                {
                }
                field("Entitlement -OutPatient"; "Entitlement -OutPatient")
                {
                }
                field("Fiscal Year"; "Fiscal Year")
                {
                }
                field("No. Of Lives"; "No. Of Lives")
                {
                }
                field("No. Series"; "No. Series")
                {
                }
                field("Cover Selected"; "Cover Selected")
                {
                }
                field("In-Patient Claims"; "In-Patient Claims")
                {
                }
                field("Out-Patient Claims"; "Out-Patient Claims")
                {
                }
                field("Date of Birth"; "Date of Birth")
                {
                }
                field("Salary Scale"; "Salary Scale")
                {
                }
                field(Gender; Gender)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        if UserSetup.GET(USERID) then begin
            SETRANGE("Employee No", UserSetup."Employee No.");
        end;
    end;

    var
        ApprovalMgt: Codeunit LogInManagement;
        UserSetup: Record "User Setup";
        ApprovalSetup: Record "G/L Account";
        UserSetupRec: Record "User Setup";
        Filterstring: Text[250];
}

