// Copyright of BeyondTech, Inc. 2014-2016. All rights reserved.
//
// Any redistribution or reproduction of part or all of the contents in any form 
// is prohibited.
//
// You may not, except with our express written permission, distribute or commercially 
// exploit the content. Nor may you transmit it or store it in any other website or 
// other form of electronic retrieval system.

#pragma once

#include <stdint.h>
#include <vector>
#include <thread>
#include <mutex>
#include <condition_variable>

namespace net {

enum Status
{
    APR_SUCCESS,
    APR_EOF,
    APR_EINTER,
    APR_EAGAIN,
};

// Thread safe FIFO bounded queue, mocking golang's channel mechanism
// see http://svn.apache.org/repos/asf/apr/apr/trunk/util-misc/apr_queue.c
template <typename T>
class ChannelQueue
{
public:
    explicit ChannelQueue(uint32_t capacity);
    ~ChannelQueue();
    
    ChannelQueue(const ChannelQueue&) = delete;
    ChannelQueue(ChannelQueue&&) = delete;
    ChannelQueue& operator=(const ChannelQueue&) = delete;

    // push/add an object to the queue, blocking if the queue is already full
    Status Push(const T& value);

    // push/add an object to the queue, returning immediately if the queue is full     
    Status TryPush(const T& value);

    // pop/get an object from the queue, blocking if the queue is already empty
    Status Pop(T* ptr);

    // pop/get an object to the queue, returning immediately if the queue is empty
    Status TryPop(T* ptr);

    // interrupt all the threads blocking on this queue.
    void InterruptAll();

    // terminate the queue, sending an interrupt to all the blocking threads
    void Terminate();

    void Reset();

    // queue capacity
    uint32_t Capacity() const { return bounds_; }

    // count of elements
    uint32_t Size() const { return nelts_; }

    // detects when the queue is full, not threadsafe
    bool IsFull() const { return nelts_ >= bounds_; }

    // detects when the queue is empty, not threadsafe
    bool IsEmpty() const { return nelts_ == 0; }

private:
    T*                      data_ = nullptr;
    uint32_t                nelts_ = 0;             // # elements
    uint32_t                in_ = 0;                // next empty location
    uint32_t                out_ = 0;               // next filled location
    const uint32_t          bounds_ = 0;            // max size of queue
    uint32_t                full_waiters_ = 0;
    uint32_t                empty_waiters_ = 0;
    std::mutex              one_big_mutex_;
    std::condition_variable not_empty_;
    std::condition_variable not_full_;
    bool                    terminated_ = false;
};

#include "ChannelQueue-inl.h"

} // namespace net

