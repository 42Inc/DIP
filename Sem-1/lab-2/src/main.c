#include <stdio.h>
#include <mpi.h>
#include <stdlib.h>
#include <math.h>

int main(int argc, char *argv[])
{
  int n = argc > 1 ? atoi(argv[1]) : 3000;
  int rank, commsize;
  int root = argc > 2 ? atoi(argv[2]) : 0;
  MPI_Init(&argc, &argv);

  FILE *file = NULL;

  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &commsize);
  const int k = 3;
  int i;
  int next = MPI_PROC_NULL;
  int prev = MPI_PROC_NULL;
  for (i = 0; i < k; ++i) {
    if (i == 1) {
      prev = (rank > 0) ? ((rank - 1 + commsize) % commsize) : MPI_PROC_NULL;
      next = (rank != commsize - 1) ? (rank + 1) % commsize : MPI_PROC_NULL;
    } else if (i == 0) {
      prev = (rank > 0) ? ((rank - 1 + commsize) % commsize) : MPI_PROC_NULL;
      next = (rank + 1) % commsize;
    } else if (i == k - 1){
      next = (rank != commsize - 1) ? (rank + 1) % commsize : MPI_PROC_NULL;
      prev = (rank - 1 + commsize) % commsize;
    } //else {
    //   next = (rank + 1) % commsize;
    //   prev = (rank - 1 + commsize) % commsize;
    // }
//    MPI_Recv(NULL, 0, MPI_INT, (rank > 0) ? rank - 1 : MPI_PROC_NULL, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    MPI_Recv(NULL, 0, MPI_INT, prev, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    __asm__ volatile ("":::"memory");
    file = fopen("out.dat", "a");
    fprintf(file, "1 Proc %d [%d]: %d [%d %d]\n", rank, commsize, i, prev, next);
    fclose(file);
    __asm__ volatile ("":::"memory");
//  for (int i = 0; i < nrows; i++)
//  printf("%d ", rows[i]);
//    MPI_Ssend(NULL, 0, MPI_INT, rank != commsize - 1 ? rank + 1 : MPI_PROC_NULL, 0, MPI_COMM_WORLD);
    MPI_Ssend(NULL, 0, MPI_INT, next, 0, MPI_COMM_WORLD);
  }
  MPI_Barrier(MPI_COMM_WORLD);

// master-slave
  int master = 0;
  if (master == rank) {
    file = fopen("out.dat", "a");
    fprintf(file, "-------------------------------------\n");
    fclose(file);

    for (i = 0; i < commsize * k; ++i) {
      if (i % commsize == master) {
        file = fopen("out.dat", "a");
        fprintf(file, "2 Proc %d [%d]: %d [%d %d]\n", rank, commsize, i / commsize, prev, next);
        fclose(file);
      } else {
        MPI_Ssend(NULL, 0, MPI_INT, i % commsize, i / commsize, MPI_COMM_WORLD);
        MPI_Recv(NULL, 0, MPI_INT, i % commsize, i / commsize, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      }
    }
  } else {
    for (i = 0; i < k; ++i) {
      MPI_Recv(NULL, 0, MPI_INT, master, i, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      file = fopen("out.dat", "a");
      fprintf(file, "2 Proc %d [%d]: %d [%d %d]\n", rank, commsize, i, prev, next);
      fclose(file);
      MPI_Ssend(NULL, 0, MPI_INT, master, i, MPI_COMM_WORLD);
    }
  }
  MPI_Finalize();
  return 0;
}
