/* Webcamoid, camera capture application.
 * Copyright (C) 2016  Gonzalo Exequiel Pedone
 */

#ifndef AKVIDEOCAPS_H
#define AKVIDEOCAPS_H

#include <QObject>
#include "akcommons.h"

class AkVideoCaps;
class AkVideoCapsPrivate;
class AkCaps;
class AkFrac;
class AkVideoFormatSpec;

using AkVideoCapsList = QList<AkVideoCaps>;

class AKCOMMONS_EXPORT AkVideoCaps: public QObject
{
    Q_OBJECT
    Q_PROPERTY(PixelFormat format READ format WRITE setFormat RESET resetFormat NOTIFY formatChanged)
    Q_PROPERTY(int bpp READ bpp CONSTANT)
    Q_PROPERTY(QSize size READ size WRITE setSize RESET resetSize NOTIFY sizeChanged)
    Q_PROPERTY(int width READ width WRITE setWidth RESET resetWidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ height WRITE setHeight RESET resetHeight NOTIFY heightChanged)
    Q_PROPERTY(AkFrac fps READ fps WRITE setFps RESET resetFps NOTIFY fpsChanged)

    public:
        enum PixelFormat
        {
            Format_none = AK_MAKE_FOURCC(0, 0, 0, 0),
            Format_unknown = Format_none,
        };
        Q_ENUM(PixelFormat)
        using PixelFormatList = QList<PixelFormat>;

        AkVideoCaps(QObject *parent=nullptr);
        AkVideoCaps(PixelFormat format, int width, int height, const AkFrac &fps);
        AkVideoCaps(PixelFormat format, const QSize &size, const AkFrac &fps);
        AkVideoCaps(const AkCaps &other);
        AkVideoCaps(const AkVideoCaps &other);
        ~AkVideoCaps();
        AkVideoCaps &operator =(const AkCaps &other);
        AkVideoCaps &operator =(const AkVideoCaps &other);
        bool operator ==(const AkVideoCaps &other) const;
        bool operator !=(const AkVideoCaps &other) const;
        operator bool() const;
        operator AkCaps() const;

        Q_INVOKABLE static QObject *create();
        Q_INVOKABLE static QObject *create(const AkCaps &caps);
        Q_INVOKABLE static QObject *create(const AkVideoCaps &caps);
        Q_INVOKABLE static QObject *create(AkVideoCaps::PixelFormat format, int width, int height, const AkFrac &fps);
        Q_INVOKABLE static QObject *create(AkVideoCaps::PixelFormat format, const QSize &size, const AkFrac &fps);
        Q_INVOKABLE QVariant toVariant() const;
        Q_INVOKABLE AkVideoCaps::PixelFormat format() const;
        Q_INVOKABLE QSize size() const;
        Q_INVOKABLE int width() const;
        Q_INVOKABLE int height() const;
        Q_INVOKABLE AkFrac fps() const;
        Q_INVOKABLE int bpp() const;
        Q_INVOKABLE AkVideoCaps nearest(const AkVideoCapsList &caps) const;
        Q_INVOKABLE bool isSameFormat(const AkVideoCaps &other) const;
        Q_INVOKABLE size_t dataSize(int align=0) const;
        Q_INVOKABLE static int bitsPerPixel(AkVideoCaps::PixelFormat pixelFormat);
        Q_INVOKABLE static QString pixelFormatToString(AkVideoCaps::PixelFormat pixelFormat);
        Q_INVOKABLE static AkVideoFormatSpec formatSpecs(AkVideoCaps::PixelFormat pixelFormat);

    private:
        AkVideoCapsPrivate *d;

    Q_SIGNALS:
        void formatChanged(AkVideoCaps::PixelFormat format);
        void sizeChanged(const QSize &size);
        void widthChanged(int width);
        void heightChanged(int height);
        void fpsChanged(const AkFrac &fps);

    public Q_SLOTS:
        void setFormat(AkVideoCaps::PixelFormat format);
        void setSize(const QSize &size);
        void setWidth(int width);
        void setHeight(int height);
        void setFps(const AkFrac &fps);
        void resetFormat();
        void resetSize();
        void resetWidth();
        void resetHeight();
        void resetFps();
        static void registerTypes();

    friend AKCOMMONS_EXPORT bool operator <(const AkVideoCaps &caps1, const AkVideoCaps &caps2);
};

AKCOMMONS_EXPORT QDebug operator <<(QDebug debug, const AkVideoCaps &caps);
AKCOMMONS_EXPORT QDebug operator <<(QDebug debug, AkVideoCaps::PixelFormat format);
AKCOMMONS_EXPORT QDataStream &operator >>(QDataStream &istream, AkVideoCaps &caps);
AKCOMMONS_EXPORT QDataStream &operator <<(QDataStream &ostream, const AkVideoCaps &caps);
AKCOMMONS_EXPORT bool operator <(const AkVideoCaps &caps1, const AkVideoCaps &caps2);

Q_DECLARE_METATYPE(AkVideoCaps)
Q_DECLARE_METATYPE(AkVideoCapsList)
Q_DECLARE_METATYPE(AkVideoCaps::PixelFormat)
Q_DECLARE_METATYPE(AkVideoCaps::PixelFormatList)

#endif // AKVIDEOCAPS_H
