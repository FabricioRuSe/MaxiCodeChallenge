using System.Data;
using System.Data.Common;

namespace CodeChallenge.DataAccess
{
    public interface IGenericRepository
    {
        IDbConnection CreateConnection();
        Task RunProcedureAsync<TParams>(TParams parameters, string query, int? commandTimeout = null) where TParams : class;
        Task<TEntity> RunProcedureAsync<TEntity, TParams>(TParams parameters, string query, int? commandTimeout = null) where TEntity : class
            where TParams : class;
        Task<IEnumerable<TEntity>> RunProcedureListAsync<TEntity>(string query, int? commandTimeout = null) where TEntity : class;
        Task<IEnumerable<TEntity>> RunProcedureListAsync<TEntity, TParams>(TParams parameters, string query, int? commandTimeout = null) where TEntity : class
            where TParams : class;
    }
}
