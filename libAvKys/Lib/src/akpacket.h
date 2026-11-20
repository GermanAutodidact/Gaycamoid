/* Webcamoid, camera capture application.
 * Copyright (C) 2016  Gonzalo Exequiel Pedone
 */

#ifndef AKPACKET_H
#define AKPACKET_H

#include "akpacketbase.h"

class AkPacketPrivate;
class AkAudioPacket;
class AkCaps;
class AkCompressedAudioPacket;
class AkCompressedVideoPacket;
class AkSubtitlePacket;
class AkVideoPacket;

class AKCOMMONS_EXPORT AkPacket: public AkPacketBase
{
    Q_OBJECT
    Q_PROPERTY(AkCaps caps READ caps CONSTANT)
    Q_PROPERTY(PacketType type READ type CONSTANT)
    Q_PROPERTY(size_t size READ size CONSTANT)

    public:
        enum PacketType
        {
            PacketUnknown = -1,
            PacketAudio,
            PacketAudioCompressed,
            PacketVideo,
            PacketVideoCompressed,
            PacketSubtitle
        };
        Q_ENUM(PacketType)

        AkPacket(QObject *parent=nullptr);
        AkPacket(const AkPacket &other);
        ~AkPacket();
        AkPacket &operator =(const AkPacket &other);
        operator bool() const;

        Q_INVOKABLE AkPacket::PacketType type() const;
        Q_INVOKABLE AkCaps caps() const;
        Q_INVOKABLE char *data() const;
        Q_INVOKABLE const char *constData() const;
        Q_INVOKABLE size_t size() const;

    private:
        AkPacketPrivate *d;
        using DataCopy = void *(*)(void *data);
        using DataDeleter = void (*)(void *data);
        void *privateData() const;
        void setPrivateData(void *data, DataCopy copyFunc, DataDeleter deleterFunc);
        void setType(AkPacket::PacketType type);

    public Q_SLOTS:
        static void registerTypes();

    friend AKCOMMONS_EXPORT QDebug operator <<(QDebug debug, const AkPacket &packet);
    friend class AkPacketPrivate;
    friend class AkAudioPacket;
    friend class AkCompressedAudioPacket;
    friend class AkCompressedVideoPacket;
    friend class AkSubtitlePacket;
    friend class AkVideoPacket;
};

AKCOMMONS_EXPORT QDebug operator <<(QDebug debug, const AkPacket &packet);

Q_DECLARE_METATYPE(AkPacket)
Q_DECLARE_METATYPE(AkPacket::PacketType)

#endif // AKPACKET_H
