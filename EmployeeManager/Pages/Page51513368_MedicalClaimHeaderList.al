page 51513368 "Medical Claim Header List"
{
    // version HR

    CardPageID = "Medical Claim Header";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Medical Claim Header";
    Caption = 'Medical Claim Header List';

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Claim No"; "Claim No")
                {
                }
                field("Claim Date"; "Claim Date")
                {
                }
                field("Service Provider"; "Service Provider")
                {
                }
                field("Service Provider Name"; "Service Provider Name")
                {
                }
                field("No. Series"; "No. Series")
                {
                }
                field(Claimant; Claimant)
                {
                }
                field(Amount; Amount)
                {
                }
                field(Settled; Settled)
                {
                }
                field("Cheque No"; "Cheque No")
                {
                }
            }
        }
    }
}

