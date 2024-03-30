using Caterers.Models;
using Microsoft.EntityFrameworkCore;

namespace Caterers.Services
{
    public class MessageServiceImpl : IMessageService
    {
        private readonly DatabaseContext db;

        public MessageServiceImpl(DatabaseContext _db)
        {
            db = _db;
        }

        public async Task<IEnumerable<Message>> GetAllMessagesAsync()
        {
            return await db.Messages.ToListAsync();
        }

        public async Task<Message> GetMessageByIdAsync(int messageId)
        {
            return await db.Messages
                .FirstOrDefaultAsync(m => m.Id == messageId);
        }

        public async Task<bool> SendMessageAsync(Message message)
        {
            if (message == null) return false;
            await db.Messages.AddAsync(message);
            await db.SaveChangesAsync();
            return true;
        }

        public async Task<bool> UpdateMessageAsync(Message message)
        {
            if (message == null) return false;
            db.Messages.Update(message);
            await db.SaveChangesAsync();
            return true;
        }

        public async Task<bool> DeleteMessageAsync(int messageId)
        {
            var message = await GetMessageByIdAsync(messageId);
            if (message == null) return false;
            db.Messages.Remove(message);
            await db.SaveChangesAsync();
            return true;
        }
    }
}