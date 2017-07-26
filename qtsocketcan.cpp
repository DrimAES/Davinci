#include "qtsocketcan.h"

QtSocketCan::QtSocketCan()
{}


// if success to connect socketcan, return positive number(can_socke)
// fail to connection? return -1
int QtSocketCan::connect_cansocket(char *backend_name)
{
    struct ifreq ifr;
    struct sockaddr_can addr;

    int can_socket;


    // If faile to connect socket can
    if( ( can_socket = socket( PF_CAN, SOCK_RAW, CAN_RAW  ) ) < 0 )
    {
        qDebug() <<  "[QtSocketCan] Fail to connect socket can ";
        return -1;
    }

    addr.can_family = AF_CAN;
    strcpy( ifr.ifr_name, backend_name );


    if( ioctl( can_socket, SIOCGIFINDEX, &ifr ) < 0 )
    {
        qDebug() <<  "[QtSocketCan] Fail to ioctl socket can ";
        return -1;
    }

    addr.can_ifindex = ifr.ifr_ifindex;

    fcntl( can_socket ,F_SETFL, O_NONBLOCK );


    // If fail to bind socket can
    if( bind( can_socket, (struct sockaddr *)&addr, sizeof(addr)) < 0 )
    {
        qDebug() <<  "[QtSocketCan] Fail to bind socket can ";
        return -1;
    }

    return can_socket;
}

void QtSocketCan::slot_read_socketcan(int can_sock)
{
    struct can_frame frame_rd;
    int recv_bytes = 0;
    struct timeval timeout = {0, 0};

    fd_set readSet;
    FD_ZERO(&readSet);
    FD_SET(can_sock, &readSet);

    if (select((can_sock + 1), &readSet, NULL, NULL, &timeout) >= 0)
    {
        if (FD_ISSET(can_sock, &readSet))
        {
            recv_bytes = read(can_sock, &frame_rd, sizeof(struct can_frame));
            emit sig_send_can_data(frame_rd, recv_bytes);

        }
    }

}

void QtSocketCan::disconnect_cansocket(int can_socket)
{
    close(can_socket);
}

