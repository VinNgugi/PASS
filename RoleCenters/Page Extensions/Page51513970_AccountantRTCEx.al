pageextension 51513970 "Account Role Center Ext" extends "Accountant Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {


        addlast(Sections)
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
            group("Finance Operation")
            {
                action("Receipt List")
                {
                    RunObject = page "Receipt List";

                }
                action("PV List")
                {
                    RunObject = page "Payments List";
                }
                action("Approved PV List")
                {
                    RunObject = page "Released Payments List";
                }

            }
        }


    }

}