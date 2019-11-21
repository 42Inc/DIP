#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include <time.h>

int main(int argc, char **argv)
{
    int rank, size, root = 0;
    MPI_Status status;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    int initiator = argv[1] ? atoi(argv[1]) : 0;
    int next = (rank + 1) % size;

    enum { STATE_PASSIVE, STATE_ACTIVE } state;
    int phase = 0, coordinator = -1, message[3];
    int is_elected = 0, is_leader = 0;
    int id = 0;
    int recv_id = 0;

    state = STATE_PASSIVE;
    id = rank;

    if (rank == initiator) {
        state = STATE_ACTIVE;
        message[0] = 0;
        message[1] = -1;
        message[2] = id;
        MPI_Send(message, 3, MPI_INT, next, 0, MPI_COMM_WORLD);
    }

    while (!is_elected) {
        MPI_Recv(message, 3, MPI_INT, MPI_ANY_SOURCE, 0, MPI_COMM_WORLD, &status);

        if (message[0] == 1) {
            coordinator = message[1];
            recv_id = message[2];
            state = STATE_PASSIVE;
            is_elected = 1;
        } else {
            if (message[2] < id) {
                state = STATE_ACTIVE; // if received id is less the its own id, make it active and send its own id
                message[2] = id;
            } else if (message[2] > id) {
                state = STATE_PASSIVE; // else make itself passive
            } else {
                is_leader = 1; // if the id comes back, it is the coordinator
                message[0] = 1; // start sending elected message with result
                message[1] = rank;
            }
            phase++;
            printf("Phase: %d, Rank:  %d, Identifier: %d, [%d] Status: ", phase, rank, id, coordinator);
            if (state == STATE_ACTIVE)
                printf("Active\n");
            else
                printf("Passive\n");
        }
        printf("[%d %d]\n", rank, coordinator);
        next = (rank + 1) % size;
        MPI_Send(message, 3, MPI_INT, coordinator == rank ? MPI_PROC_NULL : next, 0, MPI_COMM_WORLD);
    }

    if (is_leader) {
        printf("Process %d is a leader (id %d)\n", rank, id);
        id = 0;
        MPI_Allreduce(&rank, &id, 1, MPI_INT, MPI_BOR, MPI_COMM_WORLD);
        // Bcast leader to all
    } else {
        id = 0;
        MPI_Allreduce(&is_leader, &id, 1, MPI_INT, MPI_BOR, MPI_COMM_WORLD);
    }

    MPI_Barrier(MPI_COMM_WORLD);

    MPI_Recv(NULL, 0, MPI_INT, rank == 0 ? MPI_PROC_NULL : rank - 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    printf("Process %d known a leader (id %d)\n", rank, id);
    MPI_Ssend(NULL, 0, MPI_INT, rank == size - 1 ? MPI_PROC_NULL : rank + 1, 0, MPI_COMM_WORLD);

    MPI_Finalize();
    return 0;
}
