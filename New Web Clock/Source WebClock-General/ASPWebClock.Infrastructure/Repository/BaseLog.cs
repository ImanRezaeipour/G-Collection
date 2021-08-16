using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using log4net;
using System.IO;
using System.Configuration;

namespace ASPWebClock.Infrastructure.Repository
{
    /// <summary>
    /// نوع ثبت لاگ
    /// </summary>
    public enum LogLevel { Error, Fatal, Debug, Info, Warn };

    /// <summary>
    /// منبع ذخیره و ثبت لاگ
    /// </summary>
    public enum LogSource
    {
        NewWebClock
    };

    public class BaseLog
    {
        #region Variables
        static string configurationPath = "";
        static log4net.ILog NewWebClock_Log = null;
        string logAppender = "";
        LogSource _logSource;
        #endregion

        public bool IsFirstTime
        {
            get
            {
                return logAppender.Length == 0;
            }
        }

        #region Constructor
        public BaseLog()
        {
            if (IsFirstTime)
            {
                Init(LogSource.NewWebClock);
            }
        }

        public BaseLog(LogSource source)
        {
            Init(source);
        }
        #endregion

        #region Config
        private void Init(LogSource source)
        {
            _logSource = source;
            switch (source)
            {
                case LogSource.NewWebClock:
                default:
                    logAppender = "NewWebClockLog";
                    break;
            }

                ILog m_Log = GetLogFactory();
                //قسمت دوم شرط برای برنامه تستر کاربرد دارد
                if (m_Log == null || !(m_Log.IsDebugEnabled | m_Log.IsErrorEnabled | m_Log.IsFatalEnabled | m_Log.IsInfoEnabled | m_Log.IsWarnEnabled))
                {
                    LoadConfiguration();
                }

        }

        /// <summary>
        /// بارگذاري فايل تنظيمات, در صورت عدم وجود فايل تنظيمات از فايل تنظيمات اصلي بارگذاري ميشود
        /// </summary>
        private void LoadConfiguration()
        {
            log4net.Config.XmlConfigurator.Configure();

            ILog m_Log = GetLogFactory();
            m_Log = log4net.LogManager.GetLogger(logAppender);
            SetLogFactory(m_Log);
        }

        #endregion

        public ILog Logger
        {
            get
            {
                return GetLogFactory();
            }
        }

        /// <summary>
        /// مسئول خالي سازي لاگ هاي موجود در انباره مي باشد
        /// </summary>
        public void Flush()
        {
            log4net.Appender.IAppender[] appenders = log4net.LogManager
                                                            .GetRepository()
                                                            .GetLogger(this.logAppender)
                                                            .Repository
                                                            .GetAppenders();
            foreach (log4net.Appender.IAppender appender in appenders)
            {
                log4net.Appender.BufferingAppenderSkeleton buffer = appender as log4net.Appender.BufferingAppenderSkeleton;
                if (buffer != null)
                {
                    buffer.Flush();
                    // buffer.Close();
                }
            }
        }

        public void Info(object message)
        {
            ILog m_Log = GetLogFactory();
            m_Log.Info(message);
        }

        public void Info(object message, Exception exception)
        {
            ILog m_Log = GetLogFactory();
            m_Log.Info(message, exception);
        }

        public void Error(object message)
        {
            ILog m_Log = GetLogFactory();
            m_Log.Error(message);
            this.Flush();
        }

        public void Error(object message, Exception exception)
        {
            ILog m_Log = GetLogFactory();
            m_Log.Error(message, exception);
            this.Flush();
        }

        protected ILog GetLogFactory()
        {
            switch (_logSource)
            {
                case LogSource.NewWebClock:
                default:
                    return NewWebClock_Log;
            }
        }

        private void SetLogFactory(ILog m_log)
        {
            switch (_logSource)
            {
                case LogSource.NewWebClock:
                default:
                    NewWebClock_Log = m_log;
                    break;
            }
        }



    }
}
