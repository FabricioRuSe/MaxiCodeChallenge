using Dapper;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace CodeChallenge.DataAccess
{
    public class GenericRepository : IGenericRepository
    {
        private readonly string _connString = string.Empty;

        public GenericRepository(IConfiguration configuration)
        {
            _connString = configuration.GetConnectionString("SqlConnection");
        }

        public IDbConnection CreateConnection()
        {
            var conn = new SqlConnection(_connString);

            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }

            return conn;
        }

        public async Task RunProcedureAsync<TParams>(TParams parameters, string query, int? commandTimeout = null)
           where TParams : class
        {
            using var connection = CreateConnection();

            await connection.QueryAsync(query, parameters, commandType: CommandType.StoredProcedure, commandTimeout: commandTimeout);
            connection.Close();
        }

        public async Task<TEntity> RunProcedureAsync<TEntity, TParams>(TParams parameters, string query, int? commandTimeout = null)
            where TEntity : class
            where TParams : class
        {

            using var connection = CreateConnection();

            TEntity entity = await connection.QueryFirstOrDefaultAsync<TEntity>(query, parameters, commandType: CommandType.StoredProcedure, commandTimeout: commandTimeout);
            connection.Close();
            return entity;
        }

        public async Task<IEnumerable<TEntity>> RunProcedureListAsync<TEntity>(string query, int? commandTimeout = null)
            where TEntity : class
        {
            using var connection = CreateConnection();

            IEnumerable<TEntity> entity = await connection.QueryAsync<TEntity>(query, commandType: CommandType.StoredProcedure, commandTimeout: commandTimeout);
            connection.Close();
            return entity;
        }

        public async Task<IEnumerable<TEntity>> RunProcedureListAsync<TEntity, TParams>(TParams parameters, string query, int? commandTimeout = null)
            where TEntity : class
            where TParams : class
        {
            using var connection = CreateConnection();

            IEnumerable<TEntity> entity = await connection.QueryAsync<TEntity>(query, parameters, commandType: CommandType.StoredProcedure, commandTimeout: commandTimeout);
            connection.Close();
            return entity;
        }
    }
}
