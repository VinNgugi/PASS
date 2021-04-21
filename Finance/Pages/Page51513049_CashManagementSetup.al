page 51513049 "Cash Management Setup"
{
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "Cash Management Setup";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Receipt No"; "Receipt No")
                {

                }
                field("Payment Voucher Template"; "Payment Voucher Template")
                {

                }
                field("Imprest Template"; "Imprest Template")
                {

                }
                field("Imprest Surrender Template"; "Imprest Surrender Template")
                {

                }
                field("Petty Cash Template"; "Petty Cash Template")
                {

                }
                field("Receipt Template"; "Receipt Template")
                {

                }
                field("Post VAT"; "Post VAT")
                {

                }
                field("Rounding Type"; "Rounding Type")
                {

                }
                field("Rounding Precision"; "Rounding Precision")
                {

                }
                field("Petty Cash Limit"; "Petty Cash Limit")
                {

                }
                field("Imprest Limit"; "Imprest Limit")
                {

                }
                field("Imprest Due Date"; "Imprest Due Date")
                {

                }
                field("Imprest Posting Group"; "Imprest Posting Group")
                {

                }
                field("General Bus. Posting Group"; "General Bus. Posting Group")
                {

                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {

                }
                field("Bank Transfer Nos"; "Bank Transfer Nos")
                {
                    TableRelation = "No. Series".Code;
                }
                field("Petty Cash Replenishment Nos"; "Petty Cash Replenishment Nos")
                {
                    TableRelation = "No. Series".Code;
                }
            }
        }
    }




}