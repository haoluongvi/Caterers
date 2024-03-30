using System;
using System.Collections.Generic;

namespace Caterers.Models;

public partial class Message
{
    public int Id { get; set; }

    public int? SenderId { get; set; }

    public int? RecipientId { get; set; }

    public string? Content { get; set; }

    public DateTime? SentDatetime { get; set; }

    public bool? IsRead { get; set; }

    public virtual UserTable? Recipient { get; set; }

    public virtual UserTable? Sender { get; set; }
}
