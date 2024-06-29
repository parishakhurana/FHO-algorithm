#include <stdio.h>
#include <stdlib.h>

#define MAX_REQUESTS 100

void cscan(int requests[], int head, int n, int disk_size) {
    int total_distance = 0;
    int current_track = head;
    int direction = 1; 
    
    for (int i = 0; i < n - 1; ++i) {
        for (int j = 0; j < n - i - 1; ++j) {
            if (requests[j] > requests[j + 1]) {
                int temp = requests[j];
                requests[j] = requests[j + 1];
                requests[j + 1] = temp;
            }
        }
    }

    
    int i;
    for (i = 0; i < n; ++i) {
        if (requests[i] >= head) {
            break;
        }
    }

    printf("Sequence of movement:\n");

    
    for (int j = i; j < n; ++j) {
        printf("%d -> ", requests[j]);
        total_distance += abs(current_track - requests[j]);
        current_track = requests[j];
    }

    
    if (i < n) {
        printf("%d -> ", disk_size - 1);
        total_distance += abs(current_track - (disk_size - 1));
        current_track = disk_size - 1;
    }

    
    printf("0 -> ");
    total_distance += current_track;
    current_track = 0;

    
    for (int j = 0; j < i; ++j) {
        printf("%d -> ", requests[j]);
        total_distance += abs(current_track - requests[j]);
        current_track = requests[j];
    }

    printf("\nTotal distance moved: %d\n", total_distance);
}

int main() {
    int requests[MAX_REQUESTS];
    int n;
    int head;
    int disk_size;

    printf("Enter the number of requests: ");
    scanf("%d", &n);

    printf("Enter the requests: ");
    for (int i = 0; i < n; ++i) {
        scanf("%d", &requests[i]);
    }

    printf("Enter the current head position: ");
    scanf("%d", &head);

    printf("Enter the disk size: ");
    scanf("%d", &disk_size);

    cscan(requests, head, n, disk_size);

    return 0;
}
