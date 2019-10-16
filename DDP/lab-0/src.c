#include <mpi.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc,char **argv)
{
  long root = argv[1] ? atol(argv[1]) : 0;
  int rank = 0;
  int commsize = 0;
  int len = 0;
  int i = 0;
  char procname[MPI_MAX_PROCESSOR_NAME];
  char *recvbuf, *sendbuf;

  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &commsize);
  MPI_Get_processor_name(procname, &len);

  double localtime = 0;
  double remotetime = 0;
  double offset = 0.0;
  double time_average = 0.0;
  int time_count = argv[2] ? atoi(argv[2]) : 5;
  double rtt = 0;
  MPI_Status status;
  if (rank == root) {
    for (i = 0; i < time_count * (commsize - 1); ++i) {
      //if (i == root) continue;
      MPI_Recv(&remotetime, 1, MPI_DOUBLE, MPI_ANY_SOURCE, 0, MPI_COMM_WORLD, &status);
      localtime = MPI_Wtime();
      MPI_Send(&localtime, 1, MPI_DOUBLE, status.MPI_SOURCE, 0, MPI_COMM_WORLD);
    }
    printf("Root is %d/%d/%s\n");
  } else {
    srand(rank);
    int timeout = rand() % commsize * 2;
    sleep (timeout);
    for (i = 0; i < time_count; ++i) { 
      localtime = MPI_Wtime();
      MPI_Send(&localtime, 1, MPI_DOUBLE, root, 0, MPI_COMM_WORLD);
      MPI_Recv(&remotetime, 1, MPI_DOUBLE, root, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      rtt = MPI_Wtime() - localtime;
      rtt = rtt >= 0 ? rtt : -rtt;
      rtt /= 2;
      offset = remotetime - rtt;
      time_average += offset;
    }
    printf("%d/%d/%s.Time - %lf (%lf) from %d. Timeout = %d. Offset = %.12lf [%d]\n",
           rank, commsize, procname, remotetime, localtime, root, timeout, rtt, time_average / time_count, time_count);
  }

  
  MPI_Finalize();

  return 0;
}
